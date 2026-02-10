package controller;

import dao.AppointmentDAO;
import dao.ServiceDAO;
import dao.TherapistDAO;
import dao.SalonDAO;
import model.Appointment;
import model.Salon;
import model.Service;
import model.Therapist;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import model.EmailUtil;


@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int salonId = Integer.parseInt(request.getParameter("salonId"));

            Salon salon = new SalonDAO().getSalonById(salonId);
            List<Service> services = new ServiceDAO().getServicesBySalon(salonId);
            List<Therapist> therapists = new TherapistDAO().getTherapistsBySalon(salonId);

            request.setAttribute("salon", salon);
            request.setAttribute("services", services);
            request.setAttribute("therapists", therapists);

            request.getRequestDispatcher("book-appointment.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=Unable+to+load+booking+page");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int salonId = Integer.parseInt(request.getParameter("salonId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));

            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));

            Service service = new ServiceDAO().getServiceById(serviceId);

            // -----------------------------
            // 1️⃣ Check therapist availability
            // -----------------------------
            TherapistDAO tDao = new TherapistDAO();
            List<String> freeSlots = tDao.getAvailableSlots(therapistId, Date.valueOf(date));

            if (!freeSlots.contains(time.toString())) {
                request.setAttribute("error", "Selected therapist is not available at this slot.");
                doGet(request, response);
                return;
            }

            // -----------------------------
            // 2️⃣ Create Appointment with Pending status
            // -----------------------------
            Appointment appt = new Appointment();
            appt.setUserId(user.getId());
            appt.setSalonId(salonId);
            appt.setTherapistId(therapistId);
            appt.setServiceName(service.getName());
            appt.setAppointmentDate(Date.valueOf(date));
            appt.setAppointmentTime(Time.valueOf(time));
            appt.setStatus("Pending");            // Pending until owner approves
            appt.setTherapistDecision("Pending"); // Therapist decision pending

            boolean booked = new AppointmentDAO().bookAppointment(appt);

            // -----------------------------
            // 3️⃣ Handle booking result
            // -----------------------------
            if (booked) {

                // Get extra data for email
                Salon salon = new SalonDAO().getSalonById(salonId);
                Therapist therapist = new TherapistDAO().getTherapistById(therapistId);

                String customerMsg =
                        "Hello " + user.getName() + ",\n\n" +
                        "Your appointment request is submitted.\n\n" +
                        "Salon: " + salon.getName() + "\n" +
                        "Service: " + service.getName() + "\n" +
                        "Therapist: " + therapist.getName() + "\n" +
                        "Date: " + date + "\n" +
                        "Time: " + time + "\n\n" +
                        "Status: Pending approval";

                EmailUtil.sendEmail(
                        user.getEmail(),
                        "Appointment Request Submitted",
                        customerMsg
                );

                // Therapist email
                String therapistMsg =
                        "New appointment request assigned.\n\n" +
                        "Customer: " + user.getName() + "\n" +
                        "Service: " + service.getName() + "\n" +
                        "Date: " + date + "\n" +
                        "Time: " + time;

                EmailUtil.sendEmail(
                        therapist.getEmail(),
                        "New Appointment Request",
                        therapistMsg
                );

                // Optional Admin Email
                EmailUtil.sendEmail(
                        "admin@yourapp.com",
                        "New Appointment Booked",
                        "User " + user.getName() + " booked appointment."
                );

                response.sendRedirect("user-dashboard.jsp?success=Appointment+booked+pending+approval");
            }

            else {
                request.setAttribute("error", "Failed to book appointment. Try again.");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            doGet(request, response);
        }
    }
}

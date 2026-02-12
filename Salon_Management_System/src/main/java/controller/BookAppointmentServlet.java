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
import model.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    // =========================
    // GET — Load Booking Page
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int salonId = Integer.parseInt(request.getParameter("salonId"));

            SalonDAO salonDAO = new SalonDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            TherapistDAO therapistDAO = new TherapistDAO();

            request.setAttribute("salon", salonDAO.getSalonById(salonId));
            request.setAttribute("services", serviceDAO.getServicesBySalon(salonId));
            request.setAttribute("therapists", therapistDAO.getTherapistsBySalon(salonId));

            request.getRequestDispatcher("book-appointment.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=load_booking_failed");
        }
    }

    // =========================
    // POST — Book Appointment
    // =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // -------- Read Params --------
            int salonId = Integer.parseInt(request.getParameter("salonId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));

            LocalDate localDate = LocalDate.parse(request.getParameter("date"));
            LocalTime localTime = LocalTime.parse(request.getParameter("time"));

            Date sqlDate = Date.valueOf(localDate);
            Time sqlTime = Time.valueOf(localTime);

            // -------- Load Required Data --------
            ServiceDAO serviceDAO = new ServiceDAO();
            TherapistDAO therapistDAO = new TherapistDAO();
            SalonDAO salonDAO = new SalonDAO();

            Service service = serviceDAO.getServiceById(serviceId);
            Therapist therapist = therapistDAO.getTherapistById(therapistId);
            Salon salon = salonDAO.getSalonById(salonId);

            if (service == null || therapist == null || salon == null) {
                request.setAttribute("error", "Invalid booking data.");
                doGet(request, response);
                return;
            }

            // -------- Check Slot Availability --------
            List<String> freeSlots =
                    therapistDAO.getAvailableSlots(therapistId, sqlDate);

            String requestedTime = localTime.toString(); // HH:mm

            if (!freeSlots.contains(requestedTime)) {
                request.setAttribute("error",
                        "Selected therapist is not available at this time.");
                doGet(request, response);
                return;
            }

            // -------- Create Appointment --------
            Appointment appt = new Appointment();
            appt.setUserId(user.getId());
            appt.setSalonId(salonId);
            appt.setTherapistId(therapistId);
            appt.setServiceName(service.getName());
            appt.setAppointmentDate(sqlDate);
            appt.setAppointmentTime(sqlTime);
            appt.setStatus("Pending");
            appt.setTherapistDecision("Pending");

            boolean success = new AppointmentDAO().bookAppointment(appt);

            if (!success) {
                request.setAttribute("error", "Booking failed. Try again.");
                doGet(request, response);
                return;
            }

            // -------- Send Emails (non-blocking) --------
            try {

                String customerMsg =
                        "Hello " + user.getName() + ",\n\n" +
                        "Your appointment request is submitted.\n\n" +
                        "Salon: " + salon.getName() + "\n" +
                        "Service: " + service.getName() + "\n" +
                        "Therapist: " + therapist.getName() + "\n" +
                        "Date: " + localDate + "\n" +
                        "Time: " + localTime + "\n\n" +
                        "Status: Pending approval";

                EmailUtil.sendEmail(
                        user.getEmail(),
                        "Appointment Request Submitted",
                        customerMsg
                );

                String therapistMsg =
                        "New appointment request.\n\n" +
                        "Customer: " + user.getName() + "\n" +
                        "Service: " + service.getName() + "\n" +
                        "Date: " + localDate + "\n" +
                        "Time: " + localTime;

                EmailUtil.sendEmail(
                        therapist.getEmail(),
                        "New Appointment Request",
                        therapistMsg
                );

            } catch (Exception mailEx) {
                mailEx.printStackTrace(); // don’t fail booking
            }

            // -------- Redirect Success --------
            response.sendRedirect(
                "user-dashboard.jsp?success=appointment_pending");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error occurred.");
            doGet(request, response);
        }
    }
}

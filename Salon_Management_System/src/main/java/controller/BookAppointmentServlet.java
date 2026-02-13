package controller;

import dao.*;
import model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    // ==========================
    // GET → Load Booking Page
    // ==========================
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
            String salonIdStr = request.getParameter("salonId");

            if (salonIdStr == null || salonIdStr.isEmpty()) {
                response.sendRedirect("search-salons.jsp");
                return;
            }

            int salonId = Integer.parseInt(salonIdStr);

            SalonDAO salonDAO = new SalonDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            TherapistDAO therapistDAO = new TherapistDAO();

            request.setAttribute("salon", salonDAO.getSalonById(salonId));
            request.setAttribute("services", serviceDAO.getServicesBySalon(salonId));
            request.setAttribute("therapists", therapistDAO.getTherapistsBySalon(salonId));

            request.getRequestDispatcher("book-appointment.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=load_booking_failed");
        }
    }

    // ==========================
    // POST → Book Appointment
    // ==========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int salonId = Integer.parseInt(request.getParameter("salonId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));

            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));

            Date sqlDate = Date.valueOf(date);
            Time sqlTime = Time.valueOf(time);

            // ✅ Get service name (DB expects service_name, not service_id)
            Service service = new ServiceDAO().getServiceById(serviceId);

            Appointment appt = new Appointment();
            appt.setUserId(user.getId());
            appt.setSalonId(salonId);
            appt.setTherapistId(therapistId);
            appt.setServiceName(service.getName());     // ✅ FIXED
            appt.setAppointmentDate(sqlDate);
            appt.setAppointmentTime(sqlTime);
            appt.setCustomerName(user.getName());      // ✅ FIXED
            appt.setStatus("Pending");
            appt.setTherapistDecision("PENDING");
           

            boolean booked = new AppointmentDAO().bookAppointment(appt);

            if (booked) {
                response.sendRedirect("user-dashboard.jsp?success=booked");
            } else {
                response.sendRedirect("user-dashboard.jsp?error=booking_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=server_error");
        }
    }
}

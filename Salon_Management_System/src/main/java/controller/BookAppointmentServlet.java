
package controller;

import dao.AppointmentDAO;
import dao.ServiceDAO;
import dao.SalonDAO;
import model.Appointment;
import model.Salon;
import model.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate; 	
import java.time.LocalTime;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = ((model.User) session.getAttribute("user")).getId();

        try {
            String salonIdStr = request.getParameter("salonId");
            String serviceIdStr = request.getParameter("serviceId"); // from dropdown
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");

            if (salonIdStr == null || serviceIdStr == null || dateStr == null || timeStr == null
                    || salonIdStr.isEmpty() || serviceIdStr.isEmpty()) {
                request.setAttribute("error", "All fields are required.");
                request.getRequestDispatcher("book-appointment.jsp?salonId=" + salonIdStr)
                        .forward(request, response);
                return;
            }

            int salonId = Integer.parseInt(salonIdStr);
            int serviceId = Integer.parseInt(serviceIdStr);
            LocalDate date = LocalDate.parse(dateStr);
            LocalTime time = LocalTime.parse(timeStr);

            if (date.isBefore(LocalDate.now())) {
                request.setAttribute("error", "Appointment date cannot be in the past.");
                request.getRequestDispatcher("book-appointment.jsp?salonId=" + salonId)
                        .forward(request, response);
                return;
            }

            // ✅ Validate salon
            Salon salon = new SalonDAO().getSalonById(salonId);
            if (salon == null) {
                request.setAttribute("error", "Salon not found.");
                request.getRequestDispatcher("book-appointment.jsp?salonId=" + salonId)
                        .forward(request, response);
                return;
            }

            // ✅ Get service name from serviceId
            Service service = new ServiceDAO().getServiceById(serviceId);
            if (service == null) {
                request.setAttribute("error", "Service not found.");
                request.getRequestDispatcher("book-appointment.jsp?salonId=" + salonId)
                        .forward(request, response);
                return;
            }

            String serviceName = service.getName(); // store name in appointment

            // ✅ Create appointment
            Appointment appointment = new Appointment();
            appointment.setUserId(userId);
            appointment.setSalonId(salonId);
            appointment.setServiceName(serviceName);
            appointment.setAppointmentDate(java.sql.Date.valueOf(date));
            appointment.setAppointmentTime(java.sql.Time.valueOf(time));
            appointment.setStatus("BOOKED");
            appointment.setFeedbackGiven(false);

            boolean booked = new AppointmentDAO().bookAppointment(appointment);

            if (booked) {
                response.sendRedirect("user-dashboard.jsp?booked=1");
            } else {
                request.setAttribute("error", "Failed to book appointment.");
                request.getRequestDispatcher("book-appointment.jsp?salonId=" + salonId)
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
        }
    }
}


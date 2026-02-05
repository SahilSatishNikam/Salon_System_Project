package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import model.Appointment;
import model.Service;
import dao.AppointmentDAO;
import dao.ServiceDAO;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String appointmentIdStr = request.getParameter("appointmentId");
        if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
            response.sendRedirect("user-dashboard.jsp?error=Missing+appointmentId");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(appointmentIdStr);
            Appointment appointment = new AppointmentDAO().getAppointmentById(appointmentId);

            if (appointment == null || appointment.getUserId() != user.getId()) {
                response.sendRedirect("user-dashboard.jsp?error=Invalid+appointment");
                return;
            }

            Service service = new ServiceDAO().getServiceById(appointment.getSalonId());

            // Pass objects to JSP
            request.setAttribute("appointment", appointment);
            request.setAttribute("service", service);
            request.getRequestDispatcher("feedback.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("user-dashboard.jsp?error=Invalid+appointmentId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=Something+went+wrong");
        }
    }
}
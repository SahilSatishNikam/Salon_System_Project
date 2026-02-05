package controller;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            AppointmentDAO dao = new AppointmentDAO();
            boolean cancelled = dao.cancelAppointment(appointmentId);

            if (cancelled) {
                session.setAttribute("success", "Appointment cancelled successfully.");
            } else {
                session.setAttribute("error", "Failed to cancel appointment.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        }

        response.sendRedirect("myAppointments.jsp");
    }
}
package controller;

import dao.AppointmentDAO;
import model.Appointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/RescheduleAppointmentServlet")
public class RescheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(request.getParameter("id"));
        AppointmentDAO dao = new AppointmentDAO();
        try {
            Appointment appt = dao.getAppointmentById(appointmentId);
            request.setAttribute("appointment", appt);
            request.getRequestDispatcher("reschedule.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Unable to fetch appointment.");
            response.sendRedirect("myAppointments.jsp");
        }
    }

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
            LocalDate newDate = LocalDate.parse(request.getParameter("appointmentDate"));
            LocalTime newTime = LocalTime.parse(request.getParameter("appointmentTime"));

            AppointmentDAO dao = new AppointmentDAO();
            boolean updated = dao.rescheduleAppointment(appointmentId, newDate, newTime);

            if (updated) {
                session.setAttribute("success", "Appointment rescheduled successfully.");
            } else {
                session.setAttribute("error", "Failed to reschedule appointment.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        }

        response.sendRedirect("myAppointments.jsp");
    }
}
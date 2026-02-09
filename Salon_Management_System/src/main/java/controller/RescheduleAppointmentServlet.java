package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.sql.Date;
import java.sql.Time;

import dao.AppointmentDAO;

@WebServlet("/RescheduleAppointmentServlet")
public class RescheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            LocalDate date = LocalDate.parse(req.getParameter("date"));
            LocalTime time = LocalTime.parse(req.getParameter("time"));

            // Convert to java.sql.Date and java.sql.Time
            Date sqlDate = Date.valueOf(date);
            Time sqlTime = Time.valueOf(time);

            AppointmentDAO dao = new AppointmentDAO();
            boolean success = dao.rescheduleAppointment(appointmentId, sqlDate, sqlTime);

            if(success){
                req.getSession().setAttribute("msg", "Appointment rescheduled successfully!");
            } else {
                req.getSession().setAttribute("msg", "Failed to reschedule appointment.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("msg", "Error occurred while rescheduling.");
        }

        resp.sendRedirect("UserAppointmentServlet");
    }
}

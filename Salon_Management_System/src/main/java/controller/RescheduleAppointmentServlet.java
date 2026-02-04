package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RescheduleAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String date = req.getParameter("newDate");
        String time = req.getParameter("newTime");

        new AppointmentDAO().reschedule(id, date, time);
        res.sendRedirect("appointment/viewAppointments.jsp");
    }
}

package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class TimeSlotServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        int therapistId = Integer.parseInt(req.getParameter("therapistId"));
        String date = req.getParameter("date");
        String timeSlot = req.getParameter("timeSlot");

        AppointmentDAO dao = new AppointmentDAO();

        if (dao.isAvailable(therapistId, date, timeSlot)) {
            req.getRequestDispatcher("appointment/confirmAppointment.jsp")
               .forward(req, res);
        } else {
            res.sendRedirect("appointment/selectDateTime.jsp?msg=Unavailable");
        }
    }
}

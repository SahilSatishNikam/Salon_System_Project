package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ConfirmAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        AppointmentDAO dao = new AppointmentDAO();

        dao.bookAppointment(
            Integer.parseInt(req.getParameter("userId")),
            Integer.parseInt(req.getParameter("therapistId")),
            req.getParameter("date"),
            req.getParameter("timeSlot"),
            "PENDING"
        );

        res.sendRedirect("appointment/viewAppointments.jsp");
    }
}

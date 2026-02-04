package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CancelAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        new AppointmentDAO().updateStatus(id, "CANCELLED");
        res.sendRedirect("appointment/viewAppointments.jsp");
    }
}

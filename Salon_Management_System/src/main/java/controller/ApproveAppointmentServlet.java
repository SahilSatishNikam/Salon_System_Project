package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ApproveAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        new AppointmentDAO().updateStatus(id, status);
        res.sendRedirect("owner/manageAppointments.jsp");
    }
}

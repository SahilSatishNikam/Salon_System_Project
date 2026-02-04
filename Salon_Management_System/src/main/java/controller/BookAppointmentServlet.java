package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BookAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        req.setAttribute("userId", req.getParameter("userId"));
        req.setAttribute("therapistId", req.getParameter("therapistId"));
        req.setAttribute("date", req.getParameter("appointmentDate"));

        req.getRequestDispatcher("appointment/selectDateTime.jsp")
           .forward(req, res);
    }
}

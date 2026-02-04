package controller;

import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SalonBookingReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();
        req.setAttribute("salonReport", dao.getSalonWiseBookings());

        req.getRequestDispatcher("reports/salonBookings.jsp")
           .forward(req, res);
    }
}

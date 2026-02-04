package controller;

import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class TherapistPerformanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();
        req.setAttribute("performance", dao.getTherapistPerformance());

        req.getRequestDispatcher("reports/therapistPerformance.jsp")
           .forward(req, res);
    }
}

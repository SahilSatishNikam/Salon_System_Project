package controller;

import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class MonthlyRevenueReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        String month = req.getParameter("month");

        ReportDAO dao = new ReportDAO();
        double revenue = dao.getMonthlyRevenue(month);

        req.setAttribute("totalRevenue", revenue);
        req.getRequestDispatcher("reports/monthlyRevenue.jsp")
           .forward(req, res);
    }
}

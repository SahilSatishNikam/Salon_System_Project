package controller;

import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DailyAppointmentReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        String date = req.getParameter("date");

        ReportDAO dao = new ReportDAO();
        req.setAttribute("report", dao.getDailyAppointments(date));

        req.getRequestDispatcher("reports/dailyAppointments.jsp")
           .forward(req, res);
    }
}

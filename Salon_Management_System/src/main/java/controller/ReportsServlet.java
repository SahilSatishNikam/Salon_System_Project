package controller;

import dao.AppointmentDAO;
import dao.FeedbackDAO;
import dao.SalonDAO;
import dao.TherapistDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();

        int totalSalons = dao.getTotalSalons();
        int totalAppointments = dao.getTotalAppointments();
        double totalRevenue = dao.getTotalRevenue();
        double avgFeedback = dao.getAverageFeedback();
        Map<String,Integer> appointmentsPerTherapist = dao.getAppointmentsPerTherapist();

        request.setAttribute("totalSalons", totalSalons);
        request.setAttribute("totalAppointments", totalAppointments);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("avgFeedback", avgFeedback);
        request.setAttribute("appointmentsPerTherapist", appointmentsPerTherapist);

        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}

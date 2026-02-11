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

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SalonDAO salonDAO = new SalonDAO();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        TherapistDAO therapistDAO = new TherapistDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        // Example: Fetch report data
        int totalSalons = salonDAO.getTotalSalons();
        int totalAppointments = appointmentDAO.getTotalAppointments();
        double totalRevenue = appointmentDAO.getTotalRevenue();
        double avgFeedback = feedbackDAO.getAverageRating();
        Map<String, Integer> appointmentsPerTherapist = therapistDAO.getAppointmentsCountPerTherapist();

        request.setAttribute("totalSalons", totalSalons);
        request.setAttribute("totalAppointments", totalAppointments);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("avgFeedback", avgFeedback);
        request.setAttribute("appointmentsPerTherapist", appointmentsPerTherapist);

        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}

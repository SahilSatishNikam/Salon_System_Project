package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.AppointmentDAO;

/**
 * Servlet implementation class UpdateAvailabilityServlet
 */
@WebServlet("/UpdateAvailabilityServlet")
public class UpdateAvailabilityServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int therapistId = (int) req.getSession()
                .getAttribute("therapistId");

        String date = req.getParameter("date");
        String time = req.getParameter("time");

        new AppointmentDAO()
                .addAvailability(therapistId, date, time);

        res.sendRedirect("TherapistDashboardServlet");
    }

}

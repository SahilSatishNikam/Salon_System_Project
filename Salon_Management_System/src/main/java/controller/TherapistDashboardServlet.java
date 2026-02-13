package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import model.Therapist;
import model.TherapistAvailability;
import dao.AppointmentDAO;
import dao.TherapistAvailabilityDAO;

@WebServlet("/TherapistDashboardServlet")
public class TherapistDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Therapist therapist =
                (Therapist) session.getAttribute("therapist");

        if (therapist == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // ✅ put therapist in request for JSP
        req.setAttribute("therapist", therapist);

        // ✅ appointment counts
        AppointmentDAO apptDAO = new AppointmentDAO();

        req.setAttribute("todayCount",
                apptDAO.getTodayAppointmentsByTherapist(therapist.getId()));

        req.setAttribute("completedCount",
                apptDAO.getCompletedAppointmentsByTherapist(therapist.getId()));

        req.setAttribute("pendingCount",
                apptDAO.getPendingAppointmentsByTherapist(therapist.getId()));

        // ✅ availability
        TherapistAvailabilityDAO availDAO =
                new TherapistAvailabilityDAO();

        req.setAttribute("avails",
                availDAO.getUpcomingAvailability(therapist.getId()));

        req.getRequestDispatcher("therapistDashboard.jsp")
           .forward(req, resp);
    }
}

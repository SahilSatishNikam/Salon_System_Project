package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import model.Therapist;
import model.TherapistAvailability;
import dao.TherapistAvailabilityDAO;

@WebServlet("/TherapistDashboardServlet")
public class TherapistDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ Check session
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // ✅ Get logged therapist
        Therapist therapist = (Therapist) session.getAttribute("therapist");
        if (therapist == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // ✅ Basic therapist info
        req.setAttribute("therapistName", therapist.getName());
        req.setAttribute("therapistId", therapist.getId());

        // ✅ Load upcoming availability
        TherapistAvailabilityDAO availDAO = new TherapistAvailabilityDAO();
        List<TherapistAvailability> avails =
                availDAO.getUpcomingAvailability(therapist.getId());

        req.setAttribute("avails", avails);

        // ✅ Forward to dashboard JSP
        req.getRequestDispatcher("therapistDashboard.jsp")
           .forward(req, resp);
    }
}

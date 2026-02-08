package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

/**
 * Servlet implementation class TherapistAvailabilityServlet
 */
@WebServlet("/TherapistAvailabilityServlet")
public class TherapistAvailabilityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            model.Therapist t = (model.Therapist) session.getAttribute("therapist");
            if (t == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            Date date = Date.valueOf(req.getParameter("date"));
            Time start = Time.valueOf(req.getParameter("start_time") + ":00");
            Time end = Time.valueOf(req.getParameter("end_time") + ":00");
            int slotDuration = Integer.parseInt(req.getParameter("slot_duration"));

            boolean added = new dao.TherapistDAO().addAvailability(t.getId(), date, start, end, slotDuration);
            if (added) {
                resp.sendRedirect("therapistDashboard.jsp?msg=Availability+Set");
            } else {
                resp.sendRedirect("therapistDashboard.jsp?error=Failed+to+set+availability");
            }
        } catch(Exception e) {
            e.printStackTrace();
            resp.sendRedirect("therapistDashboard.jsp?error=Server+Error");
        }
    }
}


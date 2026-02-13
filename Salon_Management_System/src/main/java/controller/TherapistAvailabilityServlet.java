package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

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

            // Create availability object
            model.TherapistAvailability availability = new model.TherapistAvailability();
            availability.setTherapistId(t.getId());
            availability.setAvailableDate(date);
            availability.setStartTime(start);
            availability.setEndTime(end);
            availability.setSlotDuration(slotDuration);

            boolean added = new dao.TherapistDAO().addAvailability(availability);

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

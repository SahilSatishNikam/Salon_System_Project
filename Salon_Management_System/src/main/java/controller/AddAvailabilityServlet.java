package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import model.TherapistAvailability;
import dao.TherapistAvailabilityDAO;

@WebServlet("/AddAvailabilityServlet")
public class AddAvailabilityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int therapistId = Integer.parseInt(req.getParameter("therapistId"));
        TherapistAvailability a = new TherapistAvailability();
        a.setTherapistId(therapistId);
        a.setAvailableDate(Date.valueOf(req.getParameter("date")));
        a.setStartTime(Time.valueOf(req.getParameter("start")+":00"));
        a.setEndTime(Time.valueOf(req.getParameter("end")+":00"));
        a.setSlotDuration(Integer.parseInt(req.getParameter("duration")));

        try {
			new TherapistAvailabilityDAO().addAvailability(a);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        resp.sendRedirect("TherapistDashboardServlet");
    }
}

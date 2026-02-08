package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TherapistAvailability;

import java.io.IOException;
import java.sql.Date;

import dao.TherapistAvailabilityDAO;

/**
 * Servlet implementation class GetSlotsServlet
 */
@WebServlet("/getSlots")
public class GetSlotsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        int therapistId = Integer.parseInt(req.getParameter("therapistId"));
        Date date = Date.valueOf(req.getParameter("date"));

        TherapistAvailabilityDAO dao = new TherapistAvailabilityDAO();
        TherapistAvailability a = dao.getByTherapistDate(therapistId, date);

        if(a == null) {
            req.setAttribute("slots", null);
            req.getRequestDispatcher("slots.jsp").forward(req,res);
            return;
        }

        var slots = model.SlotGenerator.generateSlots(
                a.getStartTime().toLocalTime(),
                a.getEndTime().toLocalTime(),
                a.getSlotDuration());

        req.setAttribute("slots", slots);
        req.setAttribute("therapistId", therapistId);
        req.setAttribute("date", date);

        req.getRequestDispatcher("slots.jsp").forward(req,res);
    }
}

package controller;

import dao.TherapistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/GetAvailableSlotsServlet")
public class GetAvailableSlotsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String therapistIdStr = req.getParameter("therapistId");
        String dateStr = req.getParameter("date");

        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        if (therapistIdStr == null || therapistIdStr.isEmpty()
                || dateStr == null || dateStr.isEmpty()) {
            resp.getWriter().write("<option value=''>Select therapist and date</option>");
            return;
        }

        try {
            int therapistId = Integer.parseInt(therapistIdStr);
            Date sqlDate = Date.valueOf(LocalDate.parse(dateStr));

            TherapistDAO dao = new TherapistDAO();
            List<String> slots = dao.getAvailableSlots(therapistId, sqlDate);

            if (slots.isEmpty()) {
                resp.getWriter().write("<option value=''>No slots available</option>");
                return;
            }

            StringBuilder html = new StringBuilder();
            for (String slot : slots) {
                html.append("<option value='").append(slot).append("'>")
                    .append(slot)
                    .append("</option>");
            }

            resp.getWriter().write(html.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("<option value=''>Error loading slots</option>");
        }
    }
}

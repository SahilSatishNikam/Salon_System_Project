package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.TherapistDAO;

/**
 * Servlet implementation class GetTherapistSlotsServlet
 */
@WebServlet("/GetTherapistSlotsServlet")
public class GetTherapistSlotsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int therapistId = Integer.parseInt(req.getParameter("therapistId"));
            java.sql.Date date = java.sql.Date.valueOf(req.getParameter("date"));

            TherapistDAO dao = new TherapistDAO();
            List<String> slots = dao.getAvailableSlots(therapistId, date);

            resp.setContentType("application/json");
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for(int i = 0; i < slots.size(); i++){
                sb.append("\"").append(slots.get(i)).append("\"");
                if(i < slots.size() - 1) sb.append(",");
            }
            sb.append("]");
            resp.getWriter().write(sb.toString());

        } catch(Exception e){
            e.printStackTrace();
            resp.setStatus(500);
        }
    }
}
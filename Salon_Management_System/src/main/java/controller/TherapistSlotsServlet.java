package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import dao.SlotDAO;
import model.Slot;

@WebServlet("/slots")
public class TherapistSlotsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int therapistId = Integer.parseInt(req.getParameter("therapistId"));

        SlotDAO dao = new SlotDAO();
        List<Slot> slots = dao.getSlotsByTherapist(therapistId);

        req.setAttribute("slots", slots);
        req.getRequestDispatcher("slots.jsp").forward(req, resp);
    }
}

package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import dao.AppointmentDAO;

@WebServlet("/TherapistDecisionServlet")
public class TherapistDecisionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String decision = req.getParameter("decision"); // COMPLETED / CANCELLED

        new AppointmentDAO().updateDecision(id, decision);
        resp.sendRedirect("TherapistAppointmentServlet");
    }
}

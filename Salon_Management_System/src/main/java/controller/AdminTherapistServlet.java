package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import dao.TherapistDAO;
import dao.SalonDAO;
import model.Therapist;
import model.Salon;

@WebServlet("/AdminTherapistServlet")
public class AdminTherapistServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadPage(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            TherapistDAO therapistDAO = new TherapistDAO();

            if ("add".equalsIgnoreCase(action)) {
                // Add therapist
                int salonId = Integer.parseInt(req.getParameter("salonId"));
                String name = req.getParameter("name");
                String phone = req.getParameter("phone");
                String email = req.getParameter("email");
                String specialty = req.getParameter("specialty");
                String password = req.getParameter("password");

                Therapist t = new Therapist();
                t.setSalonId(salonId);
                t.setName(name);
                t.setPhone(phone);
                t.setEmail(email);
                t.setSpecialty(specialty);
                t.setPassword(password);
                t.setStatus("Active");   // default
                t.setApproved(0);        // default not approved

                therapistDAO.addTherapist(t);

            } else if ("status".equalsIgnoreCase(action)) {
                // Change status Active/Inactive
                int therapistId = Integer.parseInt(req.getParameter("therapistId"));
                String status = req.getParameter("status");
                therapistDAO.updateStatus(therapistId, status);
            }

            // After action, reload page
            loadPage(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Server error: " + e.getMessage());
            loadPage(req, resp);
        }
    }

    // Load therapists and salons and forward to JSP
    private void loadPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            TherapistDAO therapistDAO = new TherapistDAO();
            SalonDAO salonDAO = new SalonDAO();

            List<Therapist> therapists = therapistDAO.getAllTherapists();
            List<Salon> salons = salonDAO.getAllSalons();

            req.setAttribute("therapists", therapists);
            req.setAttribute("salons", salons);

            req.getRequestDispatcher("admin-therapists.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("admin-therapists.jsp?error=Server+Error");
        }
    }
}

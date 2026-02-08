package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.TherapistDAO;
import model.Salon;
import model.Therapist;
import model.User;

@WebServlet("/AddTherapistServlet")
public class AddTherapistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Salon salon = (Salon) session.getAttribute("salon");

        if (salon == null) {
            res.sendRedirect("manage-salon.jsp?error=Create salon first");
            return;
        }

        Therapist t = new Therapist();
        t.setName(req.getParameter("name"));
        t.setEmail(req.getParameter("email"));
        t.setPhone(req.getParameter("phone"));
        t.setSpecialty(req.getParameter("specialty"));
        t.setPassword(req.getParameter("password"));
        t.setSalonId(salon.getId());

        try {
            new TherapistDAO().addTherapist(t);
            res.sendRedirect("manage-therapists.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("add-therapist.jsp?error=1");
        }
    }
}



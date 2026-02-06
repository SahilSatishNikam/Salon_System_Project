package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.AdminDAO;
import dao.TherapistDAO;
import dao.UserDAO;

import model.Admin;
import model.Therapist;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            HttpSession session = req.getSession();

            // ✅ ADMIN LOGIN
            Admin admin = new AdminDAO().login(email, password);
            if (admin != null) {
                session.setAttribute("admin", admin);
                session.setAttribute("role", "admin");
                resp.sendRedirect("dashboard.jsp");
                return;
            }

            // ✅ THERAPIST LOGIN (only Approved)
            Therapist therapist = new TherapistDAO().login(email, password);
            if (therapist != null) {
                if (!"Approved".equalsIgnoreCase(therapist.getStatus())) {
                    resp.sendRedirect("login.jsp?error=Therapist not approved yet");
                    return;
                }
                session.setAttribute("therapist", therapist);
                session.setAttribute("role", "therapist");
                resp.sendRedirect("therapist-dashboard.jsp");
                return;
            }

            // ✅ USER LOGIN
            User user = new UserDAO().login(email, password);
            if (user != null) {
                session.setAttribute("user", user);
                session.setAttribute("role", "user");
                resp.sendRedirect("user-dashboard.jsp");
                return;
            }

            // ❌ INVALID LOGIN
            resp.sendRedirect("login.jsp?error=Invalid Email or Password");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=Server+Error");
        }
    }
}

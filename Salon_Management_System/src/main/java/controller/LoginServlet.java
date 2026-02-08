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

            // ===== Admin Login =====
            Admin admin = new AdminDAO().login(email, password);
            if (admin != null) {
                System.out.println("Admin login successful: " + admin.getName());
                session.setAttribute("role", "admin");
                session.setAttribute("admin", admin);
                resp.sendRedirect("dashboard.jsp");
                return;
            }

            // ===== Therapist Login =====
            Therapist therapist = new TherapistDAO().login(email, password);
            System.out.println("Therapist login attempt: " + email + ", therapist object: " + therapist);

            if (therapist != null) {

                // Extra safety check
                if (!"Active".equalsIgnoreCase(therapist.getStatus())) {
                    System.out.println("Therapist inactive: " + therapist.getName());
                    resp.sendRedirect("login.jsp?error=Therapist+is+inactive");
                    return;
                }

                if (therapist.getApproved() != 1) {
                    System.out.println("Therapist not approved: " + therapist.getName());
                    resp.sendRedirect("login.jsp?error=Therapist+not+approved");
                    return;
                }

                session.setAttribute("role", "therapist");
                session.setAttribute("therapist", therapist);
                System.out.println("Therapist login successful: " + therapist.getName());

                resp.sendRedirect("TherapistDashboardServlet");
                return;
            }

            // ===== User Login =====
            User user = new UserDAO().login(email, password);
            if (user != null) {
                System.out.println("User login successful: " + user.getName());
                session.setAttribute("role", "user");
                session.setAttribute("user", user);
                resp.sendRedirect("user-dashboard.jsp");
                return;
            }

            // ===== Invalid Login =====
            System.out.println("Login failed for email: " + email);
            resp.sendRedirect("login.jsp?error=Invalid+Email+or+Password");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=Server+Error");
        }
    }
}

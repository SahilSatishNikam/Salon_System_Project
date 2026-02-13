package controller;

import jakarta.servlet.ServletException;
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

        if (email == null || password == null ||
            email.isBlank() || password.isBlank()) {

            resp.sendRedirect("login.jsp?error=Enter+credentials");
            return;
        }

        email = email.trim();
        password = password.trim();

        try {

            System.out.println("LOGIN attempt for: " + email);

            // 🔥 invalidate old session to avoid role conflicts
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) oldSession.invalidate();

            HttpSession session = req.getSession(true);

            // ================= ADMIN =================
            Admin admin = new AdminDAO().login(email, password);

            if (admin != null) {

                if (!"Active".equalsIgnoreCase(admin.getStatus())) {
                    resp.sendRedirect("login.jsp?error=Admin+inactive");
                    return;
                }

                session.setAttribute("role", "admin");
                session.setAttribute("admin", admin);

                resp.sendRedirect("dashboard.jsp");
                return;
            }

            // ================= THERAPIST =================
            Therapist therapist = new TherapistDAO().login(email, password);

            if (therapist != null) {

                if (!"Active".equalsIgnoreCase(therapist.getStatus())) {
                    resp.sendRedirect("login.jsp?error=Therapist+inactive");
                    return;
                }

                if (therapist.getApproved() != 1) {
                    resp.sendRedirect("login.jsp?error=Not+approved+yet");
                    return;
                }

                session.setAttribute("role", "therapist");
                session.setAttribute("therapist", therapist);

                resp.sendRedirect(req.getContextPath() + "/TherapistDashboardServlet");

                return;
            }

            // ================= USER =================
            User user = new UserDAO().login(email, password);

            if (user != null) {
                session.setAttribute("role", "user");
                session.setAttribute("user", user);

                resp.sendRedirect("user-dashboard.jsp");
                return;
            }

            // ================= FAIL =================
            System.out.println("LOGIN FAILED for: " + email);
            resp.sendRedirect("login.jsp?error=Invalid+Email+or+Password");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=Server+Error");
        }
    }
}

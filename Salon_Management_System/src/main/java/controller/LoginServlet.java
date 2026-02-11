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

        HttpSession session = req.getSession();

        try {

            // ===== ADMIN LOGIN =====
            Admin admin = new AdminDAO().login(email, password);

            if (admin != null) {

                if (admin.getStatus() != null &&
                        !admin.getStatus().equalsIgnoreCase("Active")) {

                    resp.sendRedirect(req.getContextPath()
                            + "/login.jsp?error=Admin+is+inactive");
                    return;
                }

                session.setAttribute("role", "admin");
                session.setAttribute("admin", admin);

                resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
                return;
            }

            // ===== THERAPIST LOGIN =====
            Therapist therapist = new TherapistDAO().login(email, password);

            if (therapist != null) {

                if (!"Active".equalsIgnoreCase(therapist.getStatus())) {
                    resp.sendRedirect(req.getContextPath()
                            + "/login.jsp?error=Therapist+is+inactive");
                    return;
                }

                if (therapist.getApproved() != 1) {
                    resp.sendRedirect(req.getContextPath()
                            + "/login.jsp?error=Therapist+not+approved");
                    return;
                }

                session.setAttribute("role", "therapist");
                session.setAttribute("therapist", therapist);

                resp.sendRedirect(req.getContextPath()
                        + "/TherapistDashboardServlet");
                return;
            }

            // ===== USER LOGIN =====
            User user = new UserDAO().login(email, password);

            if (user != null) {
                session.setAttribute("role", "user");
                session.setAttribute("user", user);

                resp.sendRedirect(req.getContextPath()
                        + "/user-dashboard.jsp");
                return;
            }

            // ===== INVALID LOGIN =====
            resp.sendRedirect(req.getContextPath()
                    + "/login.jsp?error=Invalid+Email+or+Password");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath()
                    + "/login.jsp?error=Server+Error");
        }
    }
}

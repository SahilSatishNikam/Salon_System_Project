package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;
import model.Therapist;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailOrUsername = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // USER / ADMIN / THERAPIST

        try (Connection con = DBConnection.getConnection()) {

            String sql = null;

            if ("USER".equalsIgnoreCase(role)) {
                sql = "SELECT id, name, email FROM users WHERE email=? AND password=?";
            } 
            else if ("ADMIN".equalsIgnoreCase(role)) {
                sql = "SELECT id, username FROM admin WHERE username=? AND password=?";
            } 
            else if ("THERAPIST".equalsIgnoreCase(role)) {
                sql = "SELECT id, name, email FROM therapist WHERE email=? AND password=?";
            }

            if (sql == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+role");
                return;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, emailOrUsername);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("role", role.toUpperCase());

                    if ("USER".equalsIgnoreCase(role)) {
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setName(rs.getString("name"));
                        user.setEmail(rs.getString("email"));
                        session.setAttribute("user", user);

                        response.sendRedirect(request.getContextPath() + "/user/user-dashboard.jsp");
                    } 
                    else if ("ADMIN".equalsIgnoreCase(role)) {
                        Admin admin = new Admin();
                        admin.setId(rs.getInt("id"));
                        admin.setName(rs.getString("username"));
                        session.setAttribute("admin", admin);

                        response.sendRedirect(request.getContextPath() + "/admin/admin-dashboard.jsp");
                    } 
                    else if ("THERAPIST".equalsIgnoreCase(role)) {
                        Therapist t = new Therapist();
                        t.setId(rs.getInt("id"));
                        t.setName(rs.getString("name"));
                        t.setEmail(rs.getString("email"));
                        session.setAttribute("therapist", t);

                        response.sendRedirect(request.getContextPath() + "/therapist/therapist-dashboard.jsp");
                    }

                } else {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+credentials");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Login+failed");
        }
    }
}
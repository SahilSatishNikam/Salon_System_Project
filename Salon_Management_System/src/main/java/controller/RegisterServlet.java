package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        try (Connection con = DBConnection.getConnection()) {
            // Check if email exists
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email=?");
            check.setString(1, email);
            if(check.executeQuery().next()) {
                resp.sendRedirect("register.jsp?error=Email+already+exists");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users(name,email,password,phone) VALUES(?,?,?,?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.executeUpdate();

            resp.sendRedirect("login.jsp?success=Registered+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("register.jsp?error=Registration+failed");
        }
    }
}


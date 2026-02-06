package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

protected void doPost(HttpServletRequest req,
HttpServletResponse res) throws ServletException, IOException {

    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    String phone = req.getParameter("phone");
    String role = req.getParameter("role");

    try(Connection con = DBConnection.getConnection()){

        if("admin".equals(role)){

            String sql = "INSERT INTO admin(name,email,password,phone) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,email);
            ps.setString(3,password);
            ps.setString(4,phone);
            ps.executeUpdate();
        }

        else if("user".equals(role)){

            String sql = "INSERT INTO users(name,email,password,phone) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,email);
            ps.setString(3,password);
            ps.setString(4,phone);
            ps.executeUpdate();
        }

        else if("therapist".equals(role)){

            String sql = "INSERT INTO therapists(name,email,password,phone,status) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,email);
            ps.setString(3,password);
            ps.setString(4,phone);
            ps.setString(5,"Pending"); // admin approve later
            ps.executeUpdate();
        }

        res.sendRedirect("login.jsp?msg=Registered");

    }catch(Exception e){
        e.printStackTrace();
        res.sendRedirect("register.jsp?error=Registration Failed");
    }
}
}

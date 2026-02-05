package controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TherapistLoginServlet")
public class TherapistLoginServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/salon_db",
                "root",
                "root"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM therapist WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("therapistId", rs.getInt("therapist_id"));
                session.setAttribute("therapistName", rs.getString("name"));

                response.sendRedirect("therapistDashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid Email or Password");
                request.getRequestDispatcher("therapistLogin.jsp")
                       .forward(request, response);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server Error!");
            request.getRequestDispatcher("therapistLogin.jsp")
                   .forward(request, response);
        }
    }
}




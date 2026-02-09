package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Therapist;

@WebServlet("/TherapistDashboardServlet")
public class TherapistDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Therapist therapist = (Therapist) session.getAttribute("therapist");

        if (therapist == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        req.setAttribute("therapistName", therapist.getName());
        req.setAttribute("therapistId", therapist.getId());

        req.getRequestDispatcher("therapistDashboard.jsp")
           .forward(req, resp);
    }

    // ✅ MUST be outside doGet
    private int getCount(Connection con, String sql, int therapistId) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, therapistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}

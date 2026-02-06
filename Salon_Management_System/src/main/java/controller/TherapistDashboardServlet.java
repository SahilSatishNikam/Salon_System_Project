package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Appointment;

@WebServlet("/TherapistDashboardServlet")
public class TherapistDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("therapistId") == null) {
            res.sendRedirect("therapistLogin.jsp");
            return;
        }

        int therapistId = (int) session.getAttribute("therapistId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/salon_db",
                    "root",
                    "root")) {

                // ✅ Dashboard counts
                req.setAttribute("totalAppointments",
                        getCount(con,
                                "SELECT COUNT(*) FROM appointments WHERE therapist_id=?",
                                therapistId));

                req.setAttribute("todayAppointments",
                        getCount(con,
                                "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND appointment_date=CURDATE()",
                                therapistId));

                req.setAttribute("completedAppointments",
                        getCount(con,
                                "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='Completed'",
                                therapistId));

                req.setAttribute("cancelledAppointments",
                        getCount(con,
                                "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='Cancelled'",
                                therapistId));

                // ✅ Fetch all appointments
                List<Appointment> list = new ArrayList<>();
                String sql = "SELECT * FROM appointments WHERE therapist_id=? ORDER BY appointment_date DESC, appointment_time ASC";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, therapistId);
                    try (ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {
                            Appointment a = new Appointment();
                            a.setId(rs.getInt("id"));
                            a.setUserId(rs.getInt("user_id"));
                            a.setTherapistId(rs.getInt("therapist_id"));
                            a.setSalonId(rs.getInt("salon_id"));
                            a.setServiceName(rs.getString("service_name"));
                            a.setAppointmentDate(rs.getDate("appointment_date"));
                            a.setAppointmentTime(rs.getTime("appointment_time"));
                            a.setStatus(rs.getString("status"));
                            a.setFeedbackGiven(rs.getBoolean("feedback_given"));

                            list.add(a);
                        }
                    }
                }

                req.setAttribute("appointments", list);

                // ✅ Forward to JSP
                req.getRequestDispatcher("therapistDashboard.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("therapistLogin.jsp?error=Server+Error");
        }
    }

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

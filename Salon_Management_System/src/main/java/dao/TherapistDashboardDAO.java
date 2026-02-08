package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Appointment;
import util.DBConnection;

public class TherapistDashboardDAO {

    // Helper method to get count
    private int getCount(String sql, int therapistId) throws Exception {
        int count = 0;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }

    public int getTotalAppointments(int therapistId) throws Exception {
        return getCount(
            "SELECT COUNT(*) FROM appointments WHERE therapist_id=?",
            therapistId
        );
    }

    public int getTodayAppointments(int therapistId) throws Exception {
        return getCount(
            "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND appointment_date=CURDATE()",
            therapistId
        );
    }

    public int getCompletedAppointments(int therapistId) throws Exception {
        return getCount(
            "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='Completed'",
            therapistId
        );
    }

    public int getCancelledAppointments(int therapistId) throws Exception {
        return getCount(
            "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='Cancelled'",
            therapistId
        );
    }

    // Get all appointments for dashboard
    public List<Appointment> getAppointments(int therapistId) throws Exception {
        List<Appointment> list = new ArrayList<>();

        String sql = "SELECT * FROM appointments WHERE therapist_id=? ORDER BY appointment_date DESC, appointment_time ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

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
                

                list.add(a);
            }
        }

        return list;
    }
}

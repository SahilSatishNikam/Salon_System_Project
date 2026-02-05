package dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;
import model.Appointment;

public class AppointmentDAO {

    // ---------------- Book a new appointment ----------------
    public boolean bookAppointment(Appointment a) throws Exception {
        String sql = "INSERT INTO appointments(user_id, therapist_id, salon_id, service_name, appointment_date, appointment_time, status, feedback_given) VALUES(?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, a.getUserId());
            ps.setInt(2, a.getTherapistId());
            ps.setInt(3, a.getSalonId());
            ps.setString(4, a.getServiceName());
            ps.setDate(5, a.getAppointmentDate());
            ps.setTime(6, a.getAppointmentTime());
            ps.setString(7, a.getStatus() != null ? a.getStatus() : "Booked");
            ps.setBoolean(8, a.isFeedbackGiven());

            return ps.executeUpdate() > 0;
        }
    }

    // ---------------- Upcoming Appointments ----------------
    public List<Appointment> getUpcomingAppointments(int userId) throws Exception {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE user_id=? AND appointment_date >= CURDATE() AND status='Booked' ORDER BY appointment_date, appointment_time";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ---------------- Completed Appointments ----------------
    public List<Appointment> getCompletedAppointments(int userId) throws Exception {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE user_id=? AND status='Completed' ORDER BY appointment_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ---------------- Pending Feedback Count ----------------
    public int getPendingFeedbackCount(int userId) throws Exception {
        String sql = "SELECT COUNT(*) FROM appointments WHERE user_id=? AND status='Completed' AND feedback_given=false";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // ---------------- All Appointments ----------------
    public List<Appointment> getAppointmentsByUserId(int userId) throws Exception {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE user_id=? ORDER BY appointment_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ---------------- Get Appointment by ID ----------------
    public Appointment getAppointmentById(int appointmentId) throws Exception {
        String sql = "SELECT * FROM appointments WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        }
        return null;
    }

    // ---------------- Cancel Appointment ----------------
    public boolean cancelAppointment(int appointmentId) throws Exception {
        String sql = "UPDATE appointments SET status='Cancelled' WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        }
    }

    // ---------------- Reschedule Appointment ----------------
    public boolean rescheduleAppointment(int appointmentId, LocalDate date, LocalTime time) throws Exception {
        String sql = "UPDATE appointments SET appointment_date=?, appointment_time=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(date));
            ps.setTime(2, java.sql.Time.valueOf(time));
            ps.setInt(3, appointmentId);
            return ps.executeUpdate() > 0;
        }
    }

    // ---------------- Mark Appointment Completed & Add Loyalty Points ----------------
    public boolean markAppointmentCompleted(int appointmentId, int userId) throws Exception {
        String sql = "UPDATE appointments SET status='Completed' WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            int updated = ps.executeUpdate();

            if (updated > 0) {
                // ✅ Add loyalty points (10 points per completed appointment)
                String updatePointsSql = "UPDATE users SET loyalty_points = loyalty_points + 10 WHERE id=?";
                try (PreparedStatement ps2 = con.prepareStatement(updatePointsSql)) {
                    ps2.setInt(1, userId);
                    ps2.executeUpdate();
                }
                return true;
            }
        }
        return false;
    }

    // ---------------- Helper: Map ResultSet row to Appointment ----------------
    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment appt = new Appointment();
        appt.setId(rs.getInt("id"));
        appt.setUserId(rs.getInt("user_id"));
        appt.setTherapistId(rs.getInt("therapist_id"));
        appt.setSalonId(rs.getInt("salon_id"));
        appt.setServiceName(rs.getString("service_name"));
        appt.setAppointmentDate(rs.getDate("appointment_date"));
        appt.setAppointmentTime(rs.getTime("appointment_time"));
        appt.setStatus(rs.getString("status"));
        appt.setFeedbackGiven(rs.getBoolean("feedback_given"));
        return appt;
    }
}



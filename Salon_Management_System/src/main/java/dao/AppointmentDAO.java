

package dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import util.DBConnection;
import model.Appointment;

public class AppointmentDAO {

    // Book a new appointment
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
            ps.setString(7, a.getStatus() != null ? a.getStatus() : "Pending");
            ps.setBoolean(8, a.isFeedbackGiven());

            return ps.executeUpdate() > 0;
        }
    }

    // Get upcoming appointments for a user
    public List<Appointment> getUpcomingAppointments(int userId) throws Exception {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE user_id=? AND appointment_date >= CURDATE() ORDER BY appointment_date, appointment_time";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // Get all appointments for "My Appointments" page
    public List<Appointment> getAppointmentsByUserId(int userId) throws Exception {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE user_id=? ORDER BY appointment_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // Get a single appointment by ID
    public Appointment getAppointmentById(int appointmentId) throws Exception {
        String sql = "SELECT * FROM appointments WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return mapRow(rs);
        }
        return null;
    }

    // Helper method: Map ResultSet row to Appointment object
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
    
 // Cancel an appointment (mark as "Cancelled")
    public boolean cancelAppointment(int appointmentId) throws Exception {
        String sql = "UPDATE appointments SET status='Cancelled' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        }
    }

 // Reschedule appointment (update date and time)
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

}
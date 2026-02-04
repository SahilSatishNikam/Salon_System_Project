package dao;

import util.DBConnection;
import model.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public boolean isAvailable(int therapistId, String date, String timeSlot) {
        String sql = "SELECT * FROM appointment WHERE therapist_id=? AND appointment_date=? AND time_slot=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setString(2, date);
            ps.setString(3, timeSlot);

            ResultSet rs = ps.executeQuery();
            return !rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void bookAppointment(int userId, int therapistId, String date, String timeSlot, String status) {
        String sql = "INSERT INTO appointment(user_id, therapist_id, appointment_date, time_slot, status) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, therapistId);
            ps.setString(3, date);
            ps.setString(4, timeSlot);
            ps.setString(5, status);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE appointment SET status=? WHERE appointment_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reschedule(int id, String date, String time) {
        String sql = "UPDATE appointment SET appointment_date=?, time_slot=?, status='PENDING' WHERE appointment_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, date);
            ps.setString(2, time);
            ps.setInt(3, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointment";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setTherapistId(rs.getInt("therapist_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setTimeSlot(rs.getString("time_slot"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

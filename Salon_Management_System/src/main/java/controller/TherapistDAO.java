package controller;

import java.sql.*;
import java.util.*;
import model.Therapist;
import util.DBConnection;

public class TherapistDAO {

    // Add therapist
    public boolean addTherapist(Therapist t) {
        String sql = "INSERT INTO therapists (salon_id, name, phone, email, specialty, password, status, approved, therapist_decision) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getSalonId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());
            ps.setString(7, t.getStatus() != null ? t.getStatus() : "Active");
            ps.setInt(8, t.getApproved());
            ps.setString(9, t.getTherapistDecision() != null ? t.getTherapistDecision() : "Pending");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update therapist
    public boolean updateTherapist(Therapist t) {
        String sql = "UPDATE therapists SET salon_id=?, name=?, phone=?, email=?, specialty=?, password=?, status=?, approved=?, therapist_decision=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getSalonId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());
            ps.setString(7, t.getStatus());
            ps.setInt(8, t.getApproved());
            ps.setString(9, t.getTherapistDecision());
            ps.setInt(10, t.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete therapist
    public boolean deleteTherapist(int id) {
        String sql = "DELETE FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update status
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE therapists SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get therapist by ID
    public Therapist getTherapistById(int id) {
        String sql = "SELECT * FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToTherapist(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all therapists
    public List<Therapist> getAllTherapists() {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT * FROM therapists ORDER BY id DESC"; // fixed

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToTherapist(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Map ResultSet to Therapist object
    private Therapist mapResultSetToTherapist(ResultSet rs) throws SQLException {
        Therapist t = new Therapist();
        t.setId(rs.getInt("id"));
        t.setSalonId(rs.getInt("salon_id"));
        t.setName(rs.getString("name"));
        t.setPhone(rs.getString("phone"));
        t.setEmail(rs.getString("email"));
        t.setSpecialty(rs.getString("specialty"));
        t.setPassword(rs.getString("password"));
        t.setStatus(rs.getString("status"));
        t.setApproved(rs.getInt("approved"));
        t.setTherapistDecision(rs.getString("therapist_decision"));
        return t;
    }
}

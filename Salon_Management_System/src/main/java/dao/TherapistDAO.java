package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Therapist;
import util.DBConnection;

public class TherapistDAO {

    // 🔹 Register therapist
    public boolean registerTherapist(Therapist t) throws Exception {
        String sql = "INSERT INTO therapists " +
                     "(salon_id, name, phone, email, specialty, password, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Use NULL if no salon assigned yet
            if (t.getSalonId() > 0) {
                ps.setInt(1, t.getSalonId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }

            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());
            ps.setString(7, "Pending");

            return ps.executeUpdate() > 0;
        }
    }

    // 🔹 Therapist login
    public Therapist login(String email, String password) throws Exception {
        String sql = "SELECT * FROM therapists WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setPassword(rs.getString("password"));
                t.setStatus(rs.getString("status"));
                return t;
            }
        }
        return null;
    }

    // 🔹 Get all approved therapists by salon
    public List<Therapist> getTherapistsBySalon(int salonId) throws Exception {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT * FROM therapists WHERE salon_id=? AND status='Approved'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setStatus(rs.getString("status"));
                list.add(t);
            }
        }
        return list;
    }

    // 🔹 Get therapist by ID
    public Therapist getTherapistById(int id) throws Exception {
        String sql = "SELECT * FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setStatus(rs.getString("status"));
                return t;
            }
        }
        return null;
    }

    // 🔹 Approve therapist (admin)
    public boolean approveTherapist(int therapistId) throws Exception {
        String sql = "UPDATE therapists SET status='Approved' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            return ps.executeUpdate() > 0;
        }
    }
}

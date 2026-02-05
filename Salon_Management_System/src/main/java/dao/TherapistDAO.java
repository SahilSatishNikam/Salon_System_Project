package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Therapist;
import util.DBConnection;

public class TherapistDAO {

    // Fetch all therapists for a given salon
    public List<Therapist> getTherapistsBySalon(int salonId) throws Exception {
        List<Therapist> therapists = new ArrayList<>();
        String sql = "SELECT * FROM therapists WHERE salon_id=?";

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
                therapists.add(t);
            }
        }

        return therapists;
    }

    // Fetch a single therapist by ID (for appointment booking)
    public Therapist getTherapistById(int therapistId) throws Exception {
        String sql = "SELECT * FROM therapists WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                return t;
            }
        }

        return null; // Therapist not found

    }

}
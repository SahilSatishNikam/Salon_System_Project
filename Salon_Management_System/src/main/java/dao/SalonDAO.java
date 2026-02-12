package dao;

import java.io.InputStream;
import java.sql.*;
import java.util.*;
import model.Salon;
import util.DBConnection;

public class SalonDAO {

    // Add a new salon
    public void addSalon(Salon s) throws Exception {
        String sql = "INSERT INTO salons(name,email,phone,address,image,status,created_at) " +
                     "VALUES (?,?,?,?,?, 'Pending', NOW())";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getAddress());
            ps.setBytes(5, s.getImage());
            ps.executeUpdate();
        }
    }

    // Delete a salon and its services in a transaction
    public void deleteSalon(int id) throws Exception {
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps1 = con.prepareStatement(
                         "DELETE FROM services WHERE salon_id=?");
                 PreparedStatement ps2 = con.prepareStatement(
                         "DELETE FROM salons WHERE id=?")) {

                ps1.setInt(1, id);
                ps1.executeUpdate();

                ps2.setInt(1, id);
                ps2.executeUpdate();

                con.commit();
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
    }

    // Update salon status
    public void updateStatus(int id, String status) throws Exception {
        String sql = "UPDATE salons SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    // Update salon details, optionally with image
    public boolean updateSalon(int id, String name, String email, String phone, String address, InputStream imageStream){
        boolean success = false;
        String sql = (imageStream != null) 
                     ? "UPDATE salons SET name=?, email=?, phone=?, address=?, image=? WHERE id=?"
                     : "UPDATE salons SET name=?, email=?, phone=?, address=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);

            if (imageStream != null) {
                ps.setBlob(5, imageStream);
                ps.setInt(6, id);
            } else {
                ps.setInt(5, id);
            }

            success = ps.executeUpdate() > 0;

        } catch(Exception e){
            e.printStackTrace();
        }

        return success;
    }

    // Get all salons
    public List<Salon> getAllSalons() throws Exception {
        List<Salon> list = new ArrayList<>();
        String sql = "SELECT * FROM salons ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRowToSalon(rs));
            }
        }
        return list;
    }

    // Search salons by name, location, or service
    public List<Salon> searchSalons(String name, String location, Integer serviceId) throws Exception {
        List<Salon> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM salons WHERE 1=1");

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND address LIKE ?");
        }
        if (serviceId != null) {
            sql.append(" AND id IN (SELECT salon_id FROM services WHERE id = ?)");
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (name != null && !name.trim().isEmpty()) ps.setString(idx++, "%" + name + "%");
            if (location != null && !location.trim().isEmpty()) ps.setString(idx++, "%" + location + "%");
            if (serviceId != null) ps.setInt(idx++, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToSalon(rs));
                }
            }
        }

        return list;
    }

    // Get a single salon by ID
    public Salon getSalonById(int id){
        Salon salon = null;
        String sql = "SELECT * FROM salons WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if(rs.next()){
                    salon = mapRowToSalon(rs);
                }
            }
        } catch(Exception e){
            e.printStackTrace();
        }

        return salon;
    }

    // Get total number of salons
    public int getTotalSalons() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM salons";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if(rs.next()) count = rs.getInt(1);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // Map ResultSet row to Salon object
    private Salon mapRowToSalon(ResultSet rs) throws SQLException {
        Salon s = new Salon();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        s.setAddress(rs.getString("address"));
        s.setImage(rs.getBytes("image"));
        s.setCreated_at(rs.getString("created_at"));
        s.setStatus(rs.getString("status"));
        return s;
    }
}

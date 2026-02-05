package dao;

import java.sql.*;
import java.util.*;
import model.Salon;
import model.Service;
import util.DBConnection;

public class SalonDAO {

    // ✅ Add a new salon
    public void addSalon(Salon s) throws Exception {
        String sql = "INSERT INTO salons(name, email, phone, address, image, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
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

    // ✅ Update existing salon
    public void updateSalon(Salon s) throws Exception {
        String sql = "UPDATE salons SET name=?, email=?, phone=?, address=?, image=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getAddress());
            ps.setBytes(5, s.getImage());
            ps.setInt(6, s.getId());
            ps.executeUpdate();
        }
    }

    // ✅ Delete salon
    public void deleteSalon(int id) throws Exception {
        String sql = "DELETE FROM salons WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ✅ Get all salons
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

    // ✅ Get salon by ID
    public Salon getSalonById(int id) throws Exception {
        String sql = "SELECT * FROM salons WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRowToSalon(rs);
            }
        }
        return null;
    }

    // ✅ Search salons by name, address, or service
    public List<Salon> searchSalons(String name, String address, Integer serviceId) throws Exception {
        List<Salon> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT DISTINCT s.* FROM salons s ");
        if (serviceId != null) {
            sql.append(" JOIN services sr ON s.id = sr.salon_id ");
        }
        sql.append(" WHERE 1=1 ");
        if (name != null && !name.trim().isEmpty()) sql.append(" AND s.name LIKE ? ");
        if (address != null && !address.trim().isEmpty()) sql.append(" AND s.address LIKE ? ");
        if (serviceId != null) sql.append(" AND sr.id = ? ");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (name != null && !name.trim().isEmpty()) ps.setString(idx++, "%" + name + "%");
            if (address != null && !address.trim().isEmpty()) ps.setString(idx++, "%" + address + "%");
            if (serviceId != null) ps.setInt(idx++, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToSalon(rs));
                }
            }
        }
        return list;
    }

    // ✅ Helper method to map ResultSet to Salon object
    private Salon mapRowToSalon(ResultSet rs) throws SQLException {
        Salon s = new Salon();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        s.setAddress(rs.getString("address"));
        s.setImage(rs.getBytes("image"));
        return s;
    }
}



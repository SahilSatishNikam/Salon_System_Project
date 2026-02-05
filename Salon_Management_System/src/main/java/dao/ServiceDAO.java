package dao;

import java.sql.*;
import java.util.*;
import model.Service;
import util.DBConnection;

public class ServiceDAO {

    // ✅ Add a service to a specific salon
    public boolean addService(Service s) throws Exception {
        String sql = "INSERT INTO services (name, description, price, duration_minutes, salon_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getDescription());
            ps.setDouble(3, s.getPrice());
            ps.setInt(4, s.getDurationMinutes());
            ps.setInt(5, s.getSalonId());

            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Get all services for a particular salon
    public List<Service> getServicesBySalon(int salonId) throws Exception {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE salon_id = ? ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service s = new Service();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setPrice(rs.getDouble("price"));
                    s.setDurationMinutes(rs.getInt("duration_minutes"));
                    s.setSalonId(rs.getInt("salon_id"));
                    list.add(s);
                }
            }
        }
        return list;
    }

    // ✅ Delete a service (admin)
    public boolean deleteService(int serviceId) throws Exception {
        String sql = "DELETE FROM services WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Get service by id (for booking page)
    public Service getServiceById(int id) throws Exception {
        String sql = "SELECT * FROM services WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Service s = new Service();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setPrice(rs.getDouble("price"));
                    s.setDurationMinutes(rs.getInt("duration_minutes"));
                    s.setSalonId(rs.getInt("salon_id"));
                    return s;
                }
            }
        }
        return null;
    }
    
    public boolean updateService(Service s) throws Exception {
        String sql = "UPDATE services SET name=?, description=?, price=?, duration_minutes=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getDescription());
            ps.setDouble(3, s.getPrice());
            ps.setInt(4, s.getDurationMinutes());
            ps.setInt(5, s.getId());

            return ps.executeUpdate() > 0;
        }
    }

}

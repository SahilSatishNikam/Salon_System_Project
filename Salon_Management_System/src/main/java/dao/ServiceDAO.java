package dao;

import java.sql.*;
import java.util.*;
import model.Service;
import util.DBConnection;

public class ServiceDAO {

    public boolean addService(Service s) throws Exception {
        if (s.getSalonId() <= 0) {
            throw new IllegalArgumentException("Invalid salon id");
        }

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

    public List<Service> getServicesBySalon(int salonId) {
        List<Service> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM services WHERE salon_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, salonId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setPrice(rs.getDouble("price"));
                s.setDurationMinutes(rs.getInt("duration_minutes"));
                s.setSalonId(rs.getInt("salon_id"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteService(int serviceId) throws Exception {
        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement ps1 = con.prepareStatement(
                         "DELETE FROM appointments WHERE service_id=?");
                 PreparedStatement ps2 = con.prepareStatement(
                         "DELETE FROM services WHERE id=?")) {

                ps1.setInt(1, serviceId);
                ps1.executeUpdate();

                ps2.setInt(1, serviceId);
                int rows = ps2.executeUpdate();

                con.commit();
                return rows > 0;
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
    }

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
                    s.setCreatedAt(rs.getTimestamp("created_at"));
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

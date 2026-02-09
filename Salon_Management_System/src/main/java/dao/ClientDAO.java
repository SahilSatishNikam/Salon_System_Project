package dao;

import java.sql.*;
import model.Client;
import util.DBConnection;

public class ClientDAO {

    private Connection con;

    public ClientDAO() {
        try {
            con = DBConnection.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Check if client exists by phone
    public int getClientByPhone(String phone) {
        try {
            String sql = "SELECT id FROM clients WHERE phone=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return rs.getInt("id");
        } catch(Exception e){ e.printStackTrace(); }
        return 0;
    }

    // Add a new client
    public int addClient(Client c) {
        try {
            String sql = "INSERT INTO clients(name, phone, user_id) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, c.getName());
            ps.setString(2, c.getPhone());
            ps.setInt(3, c.getUserId());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()) return rs.getInt(1);
        } catch(Exception e){ e.printStackTrace(); }
        return 0;
    }

    // Add visit history
    public void addVisit(int clientId, int salonId, int therapistId, String service, Date date) {
        try {
            String sql = "INSERT INTO client_visits(client_id, salon_id, therapist_id, service_name, visit_date) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, clientId);
            ps.setInt(2, salonId);
            ps.setInt(3, therapistId);
            ps.setString(4, service);
            ps.setDate(5, date);
            ps.executeUpdate();
        } catch(Exception e){ e.printStackTrace(); }
    }
}

package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.VisitedClient;
import util.DBConnection; // Your DB connection class

public class VisitedClientDAO {

    // Fetch all visited clients
    public List<VisitedClient> getAllVisitedClients() {
        List<VisitedClient> clients = new ArrayList<>();
        String sql = "SELECT * FROM visited_clients ORDER BY visit_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VisitedClient vc = new VisitedClient();
                vc.setId(rs.getInt("id"));
                vc.setUserId(rs.getInt("user_id"));
                vc.setClientName(rs.getString("client_name"));
                vc.setClientPhone(rs.getString("client_phone"));
                vc.setSalonId(rs.getInt("salon_id"));
                vc.setSalonName(rs.getString("salon_name"));
                vc.setTherapistId(rs.getInt("therapist_id"));
                vc.setTherapistName(rs.getString("therapist_name"));
                vc.setServiceId(rs.getInt("service_id"));
                vc.setServiceName(rs.getString("service_name"));
                vc.setAmount(rs.getDouble("amount"));
                vc.setVisitDate(rs.getDate("visit_date"));
                vc.setVisitTime(rs.getTime("visit_time"));
                vc.setBookedBy(rs.getString("booked_by"));

                clients.add(vc);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clients;
    }
}

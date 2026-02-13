package dao;

import java.sql.*;
import java.util.*;
import model.VisitedClient;
import util.DBConnection;

public class VisitedClientDAO {

    // ✅ Get all visit rows
    public List<VisitedClient> getAllVisitedClients() {
        List<VisitedClient> list = new ArrayList<>();

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

                list.add(vc);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Get distinct clients
    public List<VisitedClient> getAllClients() {
        List<VisitedClient> list = new ArrayList<>();

        String sql = """
            SELECT DISTINCT client_name, client_phone
            FROM visited_clients
            ORDER BY client_name
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            int id = 1;

            while (rs.next()) {
                VisitedClient vc = new VisitedClient();
                vc.setId(id++);
                vc.setClientName(rs.getString("client_name"));
                vc.setClientPhone(rs.getString("client_phone"));
                list.add(vc);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Visits by client name
    public List<Map<String,Object>> getVisitsByClient(String clientName) {

        List<Map<String,Object>> visits = new ArrayList<>();

        String sql = """
            SELECT visit_date, salon_name
            FROM visited_clients
            WHERE client_name=?
            ORDER BY visit_date DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, clientName);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,Object> row = new HashMap<>();
                row.put("date", rs.getDate("visit_date"));
                row.put("salon", rs.getString("salon_name"));
                visits.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return visits;
    }
}

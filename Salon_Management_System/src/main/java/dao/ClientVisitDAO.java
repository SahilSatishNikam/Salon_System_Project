package dao;

import java.sql.*;
import java.util.*;
import model.Client;
import util.DBConnection;

public class ClientVisitDAO {

    private Connection con;

    public ClientVisitDAO() {
        try { con = DBConnection.getConnection(); } 
        catch(Exception e){ e.printStackTrace(); }
    }

    // Get all clients
    public List<Client> getAllClients() {
        List<Client> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM clients ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Client c = new Client();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                c.setUserId(rs.getInt("user_id"));
                list.add(c);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    // Get all visits for a client
    public List<Map<String,Object>> getVisitsByClient(int clientId){
        List<Map<String,Object>> list = new ArrayList<>();
        try {
            String sql = """
                SELECT cv.id AS visit_id, cv.visit_date, cv.service_name,
                       t.name AS therapist_name, s.name AS salon_name
                FROM client_visits cv
                LEFT JOIN therapists t ON cv.therapist_id = t.id
                LEFT JOIN salons s ON cv.salon_id = s.id
                WHERE cv.client_id = ?
                ORDER BY cv.visit_date DESC
            """;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Map<String,Object> visit = new HashMap<>();
                visit.put("visitId", rs.getInt("visit_id"));
                visit.put("date", rs.getDate("visit_date"));
                visit.put("service", rs.getString("service_name"));
                visit.put("therapist", rs.getString("therapist_name"));
                visit.put("salon", rs.getString("salon_name"));
                list.add(visit);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }
}

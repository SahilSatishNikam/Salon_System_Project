package dao;

import java.sql.*;
import java.util.*;
import model.Feedback;
import util.DBConnection;

public class FeedbackDAO {

    // Save feedback submitted by user
    public boolean saveFeedback(Feedback f) {
        boolean success = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO feedback(user, message, rating) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, f.getUser());
            ps.setString(2, f.getMessage());
            ps.setInt(3, f.getRating());
            int n = ps.executeUpdate();
            success = n > 0;
            ps.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Retrieve all feedback (latest first) for admin
    public List<Feedback> getAll() {
        List<Feedback> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM feedback ORDER BY id DESC"; // newest first
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Feedback f = new Feedback();
                f.setId(rs.getInt("id"));
                f.setUser(rs.getString("user"));
                f.setMessage(rs.getString("message"));
                f.setRating(rs.getInt("rating"));
                f.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(f);
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int getTotalFeedback() {
        int total = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) AS total FROM feedback";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                total = rs.getInt("total");
            }
            rs.close();
            ps.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return total;
    }

}

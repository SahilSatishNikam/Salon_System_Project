package dao;

import java.sql.*;
import util.DBConnection;
import model.RatingFeedback;

public class RatingFeedbackDAO {

    // Submit feedback
    public boolean submitFeedback(RatingFeedback rf) throws Exception {
        String sql = "INSERT INTO ratings_feedback(user_id, therapist_id, service_id, rating, feedback) VALUES(?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, rf.getUserId());
            ps.setInt(2, rf.getTherapistId());
            ps.setInt(3, rf.getServiceId());
            ps.setInt(4, rf.getRating());
            ps.setString(5, rf.getFeedback());
            return ps.executeUpdate() > 0;
        }
    }

    // Check if feedback already exists
    public boolean isFeedbackGiven(int userId, int serviceId, int therapistId) throws Exception {
        String sql = "SELECT * FROM ratings_feedback WHERE user_id=? AND service_id=? AND therapist_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setInt(3, therapistId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    // Get average rating for a service
    public double getAverageRatingByService(int serviceId) throws Exception {
        String sql = "SELECT AVG(rating) AS avg_rating FROM ratings_feedback WHERE service_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return rs.getDouble("avg_rating");
        }
        return 0;
    }

    // Get average rating for a therapist
    public double getAverageRatingByTherapist(int therapistId) throws Exception {
        String sql = "SELECT AVG(rating) AS avg_rating FROM ratings_feedback WHERE therapist_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return rs.getDouble("avg_rating");
        }
        return 0;
    }
}

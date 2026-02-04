package dao;

import model.Feedback;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    public void addFeedback(Feedback f) {
        String sql = "INSERT INTO feedback (user_id, salon_id, therapist_id, salon_rating, therapist_rating, comments) VALUES (?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, f.getUserId());
            ps.setInt(2, f.getSalonId());
            ps.setInt(3, f.getTherapistId());
            ps.setInt(4, f.getSalonRating());
            ps.setInt(5, f.getTherapistRating());
            ps.setString(6, f.getComments());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Feedback> getFeedbackBySalon(int salonId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE salon_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback f = new Feedback();
                f.setSalonRating(rs.getInt("salon_rating"));
                f.setTherapistRating(rs.getInt("therapist_rating"));
                f.setComments(rs.getString("comments"));
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

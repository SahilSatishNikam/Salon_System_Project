package dao;

import java.io.InputStream;
import java.sql.*;
import model.User;
import util.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) throws Exception {
        String sql = "INSERT INTO users(name,email,password,phone) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            return ps.executeUpdate() > 0;
        }
    }

    public User login(String email, String password) {
        User user = null;

        String sql = "SELECT * FROM users WHERE email=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User validateUser(String email, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phone"));
            }
        }
        return null;
    }

    public boolean updateUser(User user) throws Exception {
        String sql = "UPDATE users SET name=?, password=?, phone=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public User getUserById(int userId) throws Exception {
        String sql = "SELECT * FROM users WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setLoyaltyPoints(rs.getInt("loyalty_points")); // ✅ fetch points
                return u;
            }
        }
        return null;
    }

    public void updateUserImage(int userId, InputStream image) throws Exception {
        String sql = "UPDATE users SET image=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBlob(1, image);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

    public int getTotalUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if(rs.next()) count = rs.getInt(1);
        } catch(Exception e) { e.printStackTrace(); }
        return count;
    }

}

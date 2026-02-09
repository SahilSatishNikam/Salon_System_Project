package dao;

import java.sql.*;
import java.util.*;
import model.Admin;
import util.DBConnection;

public class AdminDAO {

    // ===============================
    // SINGLE ADMIN LOGIN
    // ===============================
    public Admin login(String email, String pass) {
        Admin admin = null;

        String sql = "SELECT * FROM admin WHERE email=? AND password=? AND status='Active' LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPhone(rs.getString("phone"));
                admin.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }

    // ===============================
    // GET ALL ADMINS
    // ===============================
    public List<Admin> getAllAdmins() {
        List<Admin> list = new ArrayList<>();
        String sql = "SELECT * FROM admins ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // DELETE ADMIN
    // ===============================
    public boolean delete(int id) {
        String sql = "DELETE FROM admins WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // UPDATE ADMIN STATUS
    // ===============================
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE admins SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

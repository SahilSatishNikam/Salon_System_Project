package dao;

import java.sql.*;
import java.util.*;
import util.DBConnection;
import model.Admin;

public class AdminDAO {

    // Register owner/admin
    public boolean register(Admin a) {
        boolean status = false;
        String sql = "INSERT INTO admin(name,email,password,phone,status) VALUES(?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, a.getName());
            ps.setString(2, a.getEmail());
            ps.setString(3, a.getPassword());
            ps.setString(4, a.getPhone());
            ps.setString(5, "Pending");

            status = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Login
    public Admin login(String email, String pass) {
        Admin admin = null;
        String sql = "SELECT * FROM admin WHERE email=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                admin.setPhone(rs.getString("phone"));
                admin.setStatus(rs.getString("status"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return admin;
    }

    // Approve / Reject owner
    public boolean updateStatus(int id, String status) {
        boolean ok = false;
        String sql = "UPDATE admin SET status=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            ok = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return ok;
    }

    // Delete owner
    public boolean delete(int id) {
        boolean ok = false;
        String sql = "DELETE FROM admin WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ok = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return ok;
    }

    // Check if owner is approved
    public boolean isApproved(int id) {
        boolean approved = false;
        String sql = "SELECT status FROM admin WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                approved = "Approved".equals(rs.getString("status"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return approved;
    }

 // Get all admins
    public List<Admin> getAllAdmins() {
        List<Admin> list = new ArrayList<>();
        String sql = "SELECT * FROM admin ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean isTherapistAvailable(int tid, String date, String time){

        String sql = """
        SELECT id FROM therapist_availability
        WHERE therapist_id=?
        AND available_date=?
        AND available_time=?
        AND is_booked=0
        """;

        try(Connection c=DBConnection.getConnection();
            PreparedStatement ps=c.prepareStatement(sql)){

            ps.setInt(1,tid);
            ps.setString(2,date);
            ps.setString(3,time);

            ResultSet rs=ps.executeQuery();
            return rs.next();

        }catch(Exception e){e.printStackTrace();}

        return false;
    }

}

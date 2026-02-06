package dao;

import java.sql.*;
import util.DBConnection;
import model.Admin;

public class AdminDAO {

    // 🔹 REGISTER ADMIN
    public boolean register(Admin a){
        boolean status = false;

        try(Connection con = DBConnection.getConnection()){
            String sql = "INSERT INTO admin(name,email,password) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, a.getName());
            ps.setString(2, a.getEmail());
            ps.setString(3, a.getPassword());

            status = ps.executeUpdate() > 0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // 🔹 LOGIN ADMIN
    public Admin login(String email, String pass){
        Admin admin = null;

        try(Connection con = DBConnection.getConnection()){
            String sql = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return admin;
    }
}

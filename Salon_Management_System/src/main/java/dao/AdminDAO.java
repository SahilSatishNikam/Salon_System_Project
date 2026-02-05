package dao;
import java.sql.*;
import util.DBConnection;
import model.Admin;

public class AdminDAO {

 // REGISTER
 public void register(Admin a){

  try{
   Connection con=DBConnection.getConnection();

   PreparedStatement ps=
   con.prepareStatement(
   "insert into admin(name,email,password) values(?,?,?)");

   ps.setString(1,a.getName());
   ps.setString(2,a.getEmail());
   ps.setString(3,a.getPassword());

   ps.executeUpdate();

  }catch(Exception e){ e.printStackTrace(); }
 }

 // LOGIN
 public boolean login(String email,String pass){

  try{
   Connection con=DBConnection.getConnection();

   PreparedStatement ps=
   con.prepareStatement(
   "select * from admin where email=? and password=?");

   ps.setString(1,email);
   ps.setString(2,pass);

   ResultSet rs=ps.executeQuery();

   return rs.next();

  }catch(Exception e){}

  return false;
 }
}


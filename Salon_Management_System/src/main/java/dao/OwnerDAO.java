


package dao;

import java.sql.*;
import java.util.*;
import model.Salon;
import util.DBConnection;

public class OwnerDAO {

 // ===== GET ALL SALON OWNERS =====
 public List<Salon> getAll(){

  List<Salon> list = new ArrayList<>();

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement("select * from salon");

   ResultSet rs = ps.executeQuery();

   while(rs.next()){

    Salon s = new Salon();

    s.setId(rs.getInt("id"));
    s.setSalon_name(rs.getString("salon_name"));
    s.setOwner_name(rs.getString("owner_name"));
    s.setStatus(rs.getString("status"));

    list.add(s);
   }

  }catch(Exception e){
   e.printStackTrace();
  }

  return list;
 }

 // ===== DELETE OWNER / SALON =====
 public void delete(int id){

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "delete from salon where id=?");

   ps.setInt(1,id);

   ps.executeUpdate();

  }catch(Exception e){
   e.printStackTrace();
  }
 }
}





package dao;

import java.sql.*;
import java.util.*;
import model.Salon;
import util.DBConnection;

public class SalonDAO {

 // ====================================
 // ADD SALON
 // ====================================
 public void addSalon(Salon s){

  try{
   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "insert into salon(salon_name,owner_name,description,image_name,status) values(?,?,?,?, 'Pending')");

   ps.setString(1, s.getSalon_name());
   ps.setString(2, s.getOwner_name());
   ps.setString(3, s.getDescription());
   ps.setString(4, s.getImage_name());

   ps.executeUpdate();

  }catch(Exception e){
   e.printStackTrace();
  }
 }

 // ====================================
 // GET ALL SALONS
 // ====================================
 public List<Salon> getAll(){

  List<Salon> list = new ArrayList<>();

  try{

   Connection c = DBConnection.getConnection();

   Statement st = c.createStatement();

   ResultSet rs = st.executeQuery("select * from salon");

   while(rs.next()){

    Salon s = new Salon();

    s.setId(rs.getInt("id"));
    s.setSalon_name(rs.getString("salon_name"));
    s.setOwner_name(rs.getString("owner_name"));
    s.setDescription(rs.getString("description"));
    s.setImage_name(rs.getString("image_name"));
    s.setStatus(rs.getString("status"));

    // 👉 if location column exists
    try{
      s.setLocation(rs.getString("location"));
    }catch(Exception ex){}

    list.add(s);
   }

  }catch(Exception e){
   e.printStackTrace();
  }

  return list;
 }

 // ====================================
 // OLD SEARCH (BY NAME ONLY)
 // ====================================
 public List<Salon> search(String key){

  List<Salon> list = new ArrayList<>();

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "select * from salon where salon_name like ?");

   ps.setString(1, "%"+key+"%");

   ResultSet rs = ps.executeQuery();

   while(rs.next()){

    Salon s = new Salon();

    s.setId(rs.getInt("id"));
    s.setSalon_name(rs.getString("salon_name"));
    s.setOwner_name(rs.getString("owner_name"));
    s.setDescription(rs.getString("description"));
    s.setImage_name(rs.getString("image_name"));
    s.setStatus(rs.getString("status"));

    try{
      s.setLocation(rs.getString("location"));
    }catch(Exception ex){}

    list.add(s);
   }

  }catch(Exception e){
   e.printStackTrace();
  }

  return list;
 }

 // ====================================
 // ✅ NEW SEARCH BY NAME + LOCATION
 // ====================================
 public List<Salon> searchByNameLocation(String name, String loc){

  List<Salon> list = new ArrayList<>();

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "select * from salon where salon_name like ? and location like ?");

   ps.setString(1, "%"+name+"%");
   ps.setString(2, "%"+loc+"%");

   ResultSet rs = ps.executeQuery();

   while(rs.next()){

    Salon s = new Salon();

    s.setId(rs.getInt("id"));
    s.setSalon_name(rs.getString("salon_name"));
    s.setOwner_name(rs.getString("owner_name"));
    s.setDescription(rs.getString("description"));
    s.setImage_name(rs.getString("image_name"));
    s.setStatus(rs.getString("status"));
    s.setLocation(rs.getString("location"));

    list.add(s);
   }

  }catch(Exception e){
   e.printStackTrace();
  }

  return list;
 }

 // ====================================
 // DELETE SALON
 // ====================================
 public void delete(int id){

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "delete from salon where id=?");

   ps.setInt(1, id);

   ps.executeUpdate();

  }catch(Exception e){
   e.printStackTrace();
  }
 }

 // ====================================
 // UPDATE STATUS
 // ====================================
 public void updateStatus(int id, String status){

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement(
   "update salon set status=? where id=?");

   ps.setString(1, status);
   ps.setInt(2, id);

   ps.executeUpdate();

  }catch(Exception e){
   e.printStackTrace();
  }
 }

}


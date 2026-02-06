package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Salon;
import util.DBConnection;

public class OwnerDAO {

 public List<Salon> getAll(){

  List<Salon> list = new ArrayList<>();

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement("select * from salons");

   ResultSet rs = ps.executeQuery();

   while(rs.next()){

    Salon s = new Salon();

    s.setId(rs.getInt("id"));
    s.setName(rs.getString("name"));
    s.setEmail(rs.getString("email"));
    s.setPhone(rs.getString("phone"));
    s.setAddress(rs.getString("address"));

    list.add(s);
   }

  }catch(Exception e){
   e.printStackTrace();
  }

  return list;
 }

 public void delete(int id){

  try{

   Connection c = DBConnection.getConnection();

   PreparedStatement ps =
   c.prepareStatement("delete from salons where id=?");

   ps.setInt(1,id);
   ps.executeUpdate();

  }catch(Exception e){
   e.printStackTrace();
  }
 }
}

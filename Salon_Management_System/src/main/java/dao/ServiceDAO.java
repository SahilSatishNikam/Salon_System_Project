

package dao;
import java.sql.*;
import java.util.*;
import model.Service;
import util.DBConnection;

public class ServiceDAO {

 public void add(Service s){

  try{
   PreparedStatement ps=
   DBConnection.getConnection()
   .prepareStatement(
   "insert into services(salon_id,name,price) values(?,?,?)");

   ps.setInt(1,s.getSalon_id());
   ps.setString(2,s.getName());
   ps.setInt(3,s.getPrice());

   ps.executeUpdate();

  }catch(Exception e){}
 }

 public List<Service> bySalon(int id){

  List<Service> list=new ArrayList<>();

  try{
   PreparedStatement ps=
   DBConnection.getConnection()
   .prepareStatement(
   "select * from services where salon_id=?");

   ps.setInt(1,id);

   ResultSet rs=ps.executeQuery();

   while(rs.next()){

    Service s=new Service();

    s.setId(rs.getInt("id"));
    s.setName(rs.getString("name"));
    s.setPrice(rs.getInt("price"));

    list.add(s);
   }

  }catch(Exception e){}

  return list;
 }
}

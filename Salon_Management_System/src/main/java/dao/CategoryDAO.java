

package dao;
import java.sql.*;
import java.util.*;
import model.Category;
import util.DBConnection;

public class CategoryDAO {

 public void add(String name){
  try{
   Connection c=DBConnection.getConnection();

   PreparedStatement ps=
   c.prepareStatement(
   "insert into service_category(category_name) values(?)");

   ps.setString(1,name);
   ps.executeUpdate();

  }catch(Exception e){ e.printStackTrace(); }
 }

 public List<Category> getAll(){

  List<Category> list=new ArrayList<>();

  try{
   Connection c=DBConnection.getConnection();

   ResultSet rs=
   c.createStatement()
   .executeQuery("select * from service_category");

   while(rs.next()){
    Category k=new Category();
    k.setId(rs.getInt(1));
    k.setName(rs.getString(2));
    list.add(k);
   }

  }catch(Exception e){}

  return list;
 }

 public void delete(int id){
  try{
   Connection c=DBConnection.getConnection();

   PreparedStatement ps=
   c.prepareStatement(
   "delete from service_category where id=?");

   ps.setInt(1,id);
   ps.executeUpdate();

  }catch(Exception e){}
 }
}


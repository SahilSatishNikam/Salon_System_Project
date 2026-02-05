package dao;
import java.sql.*;
import java.util.*;
import model.Feedback;
import util.DBConnection;

public class FeedbackDAO {

 public List<Feedback> getAll(){

  List<Feedback> list=new ArrayList<>();

  try{
   ResultSet rs=
   DBConnection.getConnection()
   .createStatement()
   .executeQuery("select * from feedback");

   while(rs.next()){

    Feedback f=new Feedback();

    f.setUser(rs.getString("user_email"));
    f.setMessage(rs.getString("message"));
    f.setRating(rs.getInt("rating"));

    list.add(f);
   }

  }catch(Exception e){}

  return list;
 }
}

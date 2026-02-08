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
 
 public int getTotalFeedback() {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM feedback";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        if(rs.next()) count = rs.getInt(1);
	    } catch(Exception e) { e.printStackTrace(); }
	    return count;
	}

}



package dao;
import java.sql.*;
import util.DBConnection;

public class ReportDAO {

 public int totalAppointments(){

  try{
   ResultSet rs=
   DBConnection.getConnection()
   .createStatement()
   .executeQuery("select count(*) from appointment");

   rs.next();
   return rs.getInt(1);

  }catch(Exception e){}

  return 0;
 }

 public int totalSalons(){

  try{
   ResultSet rs=
   DBConnection.getConnection()
   .createStatement()
   .executeQuery("select count(*) from salon");

   rs.next();
   return rs.getInt(1);

  }catch(Exception e){}

  return 0;
 }
}






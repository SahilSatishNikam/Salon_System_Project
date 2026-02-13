package dao;

import java.sql.*;
import java.util.*;
import util.DBConnection;

public class ReportDAO {

    public int getTotalSalons(){
        int count = 0;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM salon");
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
        }catch(Exception e){ e.printStackTrace(); }
        return count;
    }

    public int getTotalAppointments(){
        int count = 0;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM appointment");
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
        }catch(Exception e){ e.printStackTrace(); }
        return count;
    }

    public double getTotalRevenue(){
        double total = 0;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT SUM(price) FROM appointment WHERE status='COMPLETED'"
            );
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getDouble(1);
        }catch(Exception e){ e.printStackTrace(); }
        return total;
    }

    public double getAverageFeedback(){
        double avg = 0;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT AVG(rating) FROM feedback"
            );
            ResultSet rs = ps.executeQuery();
            if(rs.next()) avg = rs.getDouble(1);
        }catch(Exception e){ e.printStackTrace(); }
        return avg;
    }

    public Map<String,Integer> getAppointmentsPerTherapist(){

        Map<String,Integer> map = new LinkedHashMap<>();

        try{
            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT t.name, COUNT(a.id) total " +
            "FROM therapist t " +
            "LEFT JOIN appointment a ON t.id=a.therapist_id " +
            "GROUP BY t.name";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                map.put(rs.getString("name"), rs.getInt("total"));
            }

        }catch(Exception e){ e.printStackTrace(); }

        return map;
    }
}

package dao;

import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ReportDAO {

    public List<Map<String, Object>> getDailyAppointments(String date) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT a.appointment_id, t.therapist_name, a.status " +
                     "FROM appointment a JOIN therapist t ON a.therapist_id=t.therapist_id " +
                     "WHERE a.appointment_date=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("appointmentId", rs.getInt(1));
                map.put("therapistName", rs.getString(2));
                map.put("status", rs.getString(3));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getMonthlyRevenue(String month) {
        String sql = "SELECT SUM(s.price) FROM appointment a JOIN services s ON a.service_id=s.service_id " +
                     "WHERE DATE_FORMAT(a.appointment_date,'%Y-%m')=? AND a.status='COMPLETED'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getTherapistPerformance() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT t.therapist_name, COUNT(*) FROM appointment a " +
                     "JOIN therapist t ON a.therapist_id=t.therapist_id " +
                     "WHERE a.status='COMPLETED' GROUP BY t.therapist_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("therapistName", rs.getString(1));
                map.put("totalAppointments", rs.getInt(2));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getSalonWiseBookings() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT salon_id, COUNT(*) FROM appointment GROUP BY salon_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("salonName", "Salon " + rs.getInt(1));
                map.put("totalBookings", rs.getInt(2));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

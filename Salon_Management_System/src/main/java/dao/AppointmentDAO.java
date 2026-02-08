package dao;

import java.sql.*;
import java.util.*;
import model.Appointment;
import util.DBConnection;

public class AppointmentDAO {

    // ===============================
    // BOOK APPOINTMENT (USER)
    // ===============================
    public boolean bookAppointment(Appointment appt) {

        String sql = """
            INSERT INTO appointments
            (user_id, therapist_id, salon_id, service_name,
             appointment_date, appointment_time, status, therapist_decision)
            VALUES (?,?,?,?,?,?, 'BOOKED','PENDING')
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, appt.getUserId());
            ps.setInt(2, appt.getTherapistId());
            ps.setInt(3, appt.getSalonId());
            ps.setString(4, appt.getServiceName());
            ps.setDate(5, appt.getAppointmentDate());
            ps.setTime(6, appt.getAppointmentTime());

            return ps.executeUpdate() > 0;

        } catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // ADMIN + THERAPIST UPDATE STATUS
    // ===============================
    public boolean updateStatus(int id, String status, String decision) {

        boolean success = false;

        String sql = "UPDATE appointments SET status=?, therapist_decision=? WHERE id=?";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setString(1, status);
            ps.setString(2, decision);
            ps.setInt(3, id);

            success = ps.executeUpdate() > 0;

        } catch(Exception e){
            e.printStackTrace();
        }
        return success;
    }

    // ===============================
    // GET ALL APPOINTMENTS (ADMIN)
    // ===============================
    public List<Appointment> getAllAppointments() {

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT a.*, 
                   u.name AS user_name,
                   t.name AS therapist_name,
                   s.name AS salon_name
            FROM appointments a
            LEFT JOIN users u ON a.user_id = u.id
            LEFT JOIN therapists t ON a.therapist_id = t.id
            LEFT JOIN salons s ON a.salon_id = s.id
            ORDER BY a.id DESC
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){
                Appointment a = mapRow(rs);
                list.add(a);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // THERAPIST APPOINTMENTS
    // ===============================
    public List<Appointment> getAppointmentsByTherapist(int therapistId){

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT a.*, u.name AS customer_name
            FROM appointments a
            JOIN users u ON a.user_id = u.id
            WHERE a.therapist_id=?
            ORDER BY appointment_date, appointment_time
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Appointment a = mapRow(rs);
                a.setCustomerName(rs.getString("customer_name"));
                list.add(a);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // USER APPOINTMENTS
    // ===============================
    public List<Appointment> getAppointmentsByUserId(int userId){

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT * FROM appointments
            WHERE user_id=?
            ORDER BY appointment_date, appointment_time
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(mapRow(rs));
            }

        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    // ===============================
    // COUNTS FOR THERAPIST DASHBOARD
    // ===============================
    public int countToday(int therapistId){
        return count("SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND appointment_date=CURDATE()", therapistId);
    }

    public int countCompleted(int therapistId){
        return count("SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='COMPLETED'", therapistId);
    }

    public int countPending(int therapistId){
        return count("SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='BOOKED'", therapistId);
    }

    private int count(String sql, int therapistId){

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) return rs.getInt(1);

        } catch(Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    // ===============================
    // CANCEL APPOINTMENT (USER)
    // ===============================
    public boolean cancelAppointment(int id){

        String sql = "UPDATE appointments SET status='CANCELLED' WHERE id=?";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    // ===============================
    // MAP RESULTSET → OBJECT
    // ===============================
    private Appointment mapRow(ResultSet rs) throws SQLException {

        Appointment a = new Appointment();

        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("user_id"));
        a.setTherapistId(rs.getInt("therapist_id"));
        a.setSalonId(rs.getInt("salon_id"));
        a.setServiceName(rs.getString("service_name"));
        a.setAppointmentDate(rs.getDate("appointment_date"));
        a.setAppointmentTime(rs.getTime("appointment_time"));
        a.setStatus(rs.getString("status"));
        a.setTherapistDecision(rs.getString("therapist_decision"));

        return a;
    }
    
    public List<Appointment> getUpcomingAppointments(int userId){

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT *
            FROM appointments
            WHERE user_id = ?
            AND (
                appointment_date > CURDATE()
                OR (appointment_date = CURDATE()
                    AND appointment_time >= CURTIME())
            )
            ORDER BY appointment_date, appointment_time
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(mapRow(rs));
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public List<Appointment> getCompletedAppointments(int userId){

        List<Appointment> list = new ArrayList<>();

        String sql = """
            SELECT *
            FROM appointments
            WHERE user_id = ?
            AND status = 'Completed'
            ORDER BY appointment_date DESC, appointment_time DESC
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(mapRow(rs));
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public int getCompletedAppointmentsByTherapist(int therapistId){
        int count = 0;
        try{
            Connection con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='COMPLETED'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
        }catch(Exception e){ e.printStackTrace(); }
        return count;
    }

    public int getPendingAppointmentsByTherapist(int therapistId){
        int count = 0;
        try{
            Connection con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND status='BOOKED'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
        }catch(Exception e){ e.printStackTrace(); }
        return count;
    }

    public int getTotalAppointments() {

        String sql = "SELECT COUNT(*) FROM appointments";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
    
    public boolean updateAppointmentStatus(int id, String status){
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE appointments SET status=? WHERE id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    
    public void completeAppointment(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE appointments SET status='COMPLETED', therapist_decision='APPROVED' WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public int getTodayAppointmentsByTherapist(int therapistId){
        int count = 0;
        try{
            Connection con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND appointment_date = CURDATE()";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
        }catch(Exception e){ e.printStackTrace(); }
        return count;
    }


 }



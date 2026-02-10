package dao;

import java.sql.*;
import java.sql.Date;
import java.time.LocalTime;
import java.util.*;
import model.Therapist;
import util.DBConnection;

public class TherapistDAO {
	
	 public Therapist login(String email, String password) throws Exception {
	        String sql = "SELECT * FROM therapists "
	                   + "WHERE email=? AND password=? AND status='Active' AND approved=1";

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, email);
	            ps.setString(2, password);

	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    Therapist t = new Therapist();
	                    t.setId(rs.getInt("id"));
	                    t.setSalonId(rs.getInt("salon_id"));
	                    t.setName(rs.getString("name"));
	                    t.setPhone(rs.getString("phone"));
	                    t.setEmail(rs.getString("email"));
	                    t.setSpecialty(rs.getString("specialty"));
	                    t.setPassword(rs.getString("password"));
	                    t.setStatus(rs.getString("status"));
	                    t.setTherapistDecision(rs.getString("therapist_decision"));
	                    t.setApproved(rs.getInt("approved"));
	                    return t;
	                }
	            }
	        }

	        // No matching therapist found
	        return null;
	    }

    // Add therapist availability
    public boolean addAvailability(int therapistId, Date date, Time start, Time end, int slotDuration) throws Exception {
        String sql = "INSERT INTO therapist_availability (therapist_id, available_date, start_time, end_time, slot_duration) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ps.setTime(3, start);
            ps.setTime(4, end);
            ps.setInt(5, slotDuration);
            return ps.executeUpdate() > 0;
        }
    }

    // Check if therapist available at a specific slot
    public boolean isTherapistAvailable(int therapistId, Date date, Time time) throws Exception {
        String sql = "SELECT * FROM therapist_availability WHERE therapist_id=? AND available_date=? AND start_time <= ? AND end_time >= ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ps.setTime(3, time);
            ps.setTime(4, time);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
    
    public List<String> getAvailableSlots(int therapistId, java.sql.Date date) throws Exception {
        List<String> slots = new ArrayList<>();

        String availQuery = "SELECT start_time, end_time FROM therapist_availability "
                          + "WHERE therapist_id=? AND available_date=?";
        String bookedQuery = "SELECT appointment_time FROM appointments "
                           + "WHERE therapist_id=? AND appointment_date=? AND status IN ('Pending','Confirmed','Booked')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement psAvail = con.prepareStatement(availQuery);
             PreparedStatement psBooked = con.prepareStatement(bookedQuery)) {

            // 1️⃣ Get therapist availability
            psAvail.setInt(1, therapistId);
            psAvail.setDate(2, date);
            ResultSet rsAvail = psAvail.executeQuery();

            List<Time[]> availableRanges = new ArrayList<>();
            while (rsAvail.next()) {
                Time start = rsAvail.getTime("start_time");
                Time end = rsAvail.getTime("end_time");
                availableRanges.add(new Time[]{start, end});
            }

            if (availableRanges.isEmpty()) {
                return slots; // therapist not available on this day
            }

            // 2️⃣ Get booked appointment times
            psBooked.setInt(1, therapistId);
            psBooked.setDate(2, date);
            ResultSet rsBooked = psBooked.executeQuery();

            // Use HashSet for O(1) lookup
            Set<LocalTime> bookedTimes = new HashSet<>();
            while (rsBooked.next()) {
                bookedTimes.add(rsBooked.getTime("appointment_time").toLocalTime());
            }

            // 3️⃣ Generate 30-min slots for each available range
            for (Time[] range : availableRanges) {
                LocalTime start = range[0].toLocalTime();
                LocalTime end = range[1].toLocalTime();

                while (!start.isAfter(end.minusMinutes(30))) {
                    if (!bookedTimes.contains(start)) {
                        slots.add(start.toString()); // convert to string only when adding
                    }
                    start = start.plusMinutes(30); // next slot
                }
            }
        }

        return slots;
    }

    
    public List<Therapist> getTherapistsBySalon(int salonId) throws Exception {
        List<Therapist> therapists = new ArrayList<>();

        String sql = "SELECT * FROM therapists WHERE salon_id=? AND status='Active' AND approved=1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Therapist t = new Therapist();
                    t.setId(rs.getInt("id"));
                    t.setSalonId(rs.getInt("salon_id"));
                    t.setName(rs.getString("name"));
                    t.setPhone(rs.getString("phone"));
                    t.setEmail(rs.getString("email"));
                    t.setSpecialty(rs.getString("specialty"));
                    t.setStatus(rs.getString("status"));
                    t.setApproved(rs.getInt("approved"));
                    therapists.add(t);
                }
            }
        }

        return therapists;
    }
    
    public boolean isSlotBooked(int therapistId, Date date, Time time) {

        String sql = "SELECT COUNT(*) FROM appointments " +
                     "WHERE therapist_id=? AND appointment_date=? " +
                     "AND slot_time=? AND status!='CANCELLED'";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ps.setTime(3, time);

            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch(Exception e){ e.printStackTrace(); }

        return false;
    }

    public boolean addTherapist(Therapist t) throws Exception {

        String sql = "INSERT INTO therapists "
                   + "(salon_id, name, phone, email, specialty, password, status, approved) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getSalonId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());

            // Default status = Active
            ps.setString(7, "Active");

            // Default approved = 0 (Not approved yet)
            ps.setInt(8, 0);

            return ps.executeUpdate() > 0;
        }
    }
    
    public List<Therapist> getAllTherapists() throws Exception {
        List<Therapist> list = new ArrayList<>();

        String sql = "SELECT * FROM therapists ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setStatus(rs.getString("status"));
                t.setApproved(rs.getInt("approved"));
                list.add(t);
            }
        }

        return list;
    }
    
    public void updateStatus(int id, String status){

        String sql = "UPDATE appointments SET status=? WHERE id=?";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public boolean approveTherapist(int therapistId) throws Exception {
        String sql = "UPDATE therapists SET approved=1 WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            return ps.executeUpdate() > 0;
        }
    }

    public Therapist getTherapistById(int therapistId) throws Exception {
        String sql = "SELECT * FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Therapist t = new Therapist();
                    t.setId(rs.getInt("id"));
                    t.setSalonId(rs.getInt("salon_id"));
                    t.setName(rs.getString("name"));
                    t.setPhone(rs.getString("phone"));
                    t.setEmail(rs.getString("email"));
                    t.setSpecialty(rs.getString("specialty"));
                    t.setStatus(rs.getString("status"));
                    t.setApproved(rs.getInt("approved"));
                    return t;
                }
            }
        }
        return null;
    }
    
    public void updateTherapistDecision(int id, String decision){
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "update therapists set therapist_decision=? where id=?"
            );
            ps.setString(1, decision);
            ps.setInt(2, id);
            ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public List<String> getTherapistSlotRange(int therapistId, String date) {

        List<String> list = new ArrayList<>();

        String sql = """
            SELECT start_time, end_time, duration
            FROM therapist_slots
            WHERE therapist_id=? AND work_date=?
        """;

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, therapistId);
            ps.setDate(2, Date.valueOf(date));

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Time start = rs.getTime("start_time");
                Time end   = rs.getTime("end_time");
                int dur    = rs.getInt("duration");

                LocalTime s = start.toLocalTime();
                LocalTime e = end.toLocalTime();

                while(!s.plusMinutes(dur).isAfter(e)) {
                    list.add(s.toString().substring(0,5));
                    s = s.plusMinutes(dur);
                }
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public List<Therapist> getBySalon(int salonId) {

        List<Therapist> list = new ArrayList<>();

        String sql = "SELECT * FROM therapists WHERE salon_id=?";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setSpecialty(rs.getString("specialty"));
                list.add(t);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Therapist> getTherapistsByService(int serviceId){
        List<Therapist> therapists = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection()){
            String sql = "SELECT t.id, t.name, t.specialty FROM therapists t " +
                         "JOIN therapist_services ts ON t.id = ts.therapist_id " +
                         "WHERE ts.service_id = ? AND t.status='Active'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setSpecialty(rs.getString("specialty"));
                therapists.add(t);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return therapists;
    }


}






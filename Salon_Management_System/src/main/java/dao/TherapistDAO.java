package dao;

import java.sql.*;
import java.sql.Date;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import model.Therapist;
import model.TherapistAvailability;
import util.DBConnection;

public class TherapistDAO {
	
	public Therapist login(String email, String password) throws Exception {
	    String sql = "SELECT * FROM therapists WHERE email=? AND password=?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, email);
	        ps.setString(2, password);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                Therapist t = new Therapist();
	                t.setId(rs.getInt("id"));
	                t.setName(rs.getString("name"));
	                t.setEmail(rs.getString("email"));
	                t.setPhone(rs.getString("phone"));
	                t.setStatus(rs.getString("status"));
	                t.setSalonId(rs.getInt("salon_id"));
	                t.setApproved(rs.getInt("approved")); // ✅ ADD THIS LINE
	                return t;
	            }
	        }
	    }
	    return null;
	}



    // ================= ADD THERAPIST =================
    public boolean addTherapist(Therapist t) {
        String sql = "INSERT INTO therapists (salon_id, name, phone, email, specialty, password, status, approved, therapist_decision) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getSalonId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());
            ps.setString(7, t.getStatus() != null ? t.getStatus() : "Active");
            ps.setInt(8, t.getApproved());
            ps.setString(9, t.getTherapistDecision() != null ? t.getTherapistDecision() : "Pending");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= UPDATE THERAPIST =================
    public boolean updateTherapist(Therapist t) {
        String sql = "UPDATE therapists SET salon_id=?, name=?, phone=?, email=?, specialty=?, password=?, status=?, approved=?, therapist_decision=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getSalonId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getPhone());
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getSpecialty());
            ps.setString(6, t.getPassword());
            ps.setString(7, t.getStatus());
            ps.setInt(8, t.getApproved());
            ps.setString(9, t.getTherapistDecision());
            ps.setInt(10, t.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= DELETE THERAPIST =================
    public boolean deleteTherapist(int id) {
        String sql = "DELETE FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= UPDATE STATUS =================
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE therapists SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= GET BY ID =================
    public Therapist getTherapistById(int id) {
        String sql = "SELECT * FROM therapists WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToTherapist(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= GET ALL =================
    public List<Therapist> getAllTherapists() {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT * FROM therapists ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToTherapist(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= MAP RESULT =================
    private Therapist mapResultSetToTherapist(ResultSet rs) throws SQLException {
        Therapist t = new Therapist();
        t.setId(rs.getInt("id"));
        t.setSalonId(rs.getInt("salon_id"));
        t.setName(rs.getString("name"));
        t.setPhone(rs.getString("phone"));
        t.setEmail(rs.getString("email"));
        t.setSpecialty(rs.getString("specialty"));
        t.setPassword(rs.getString("password"));
        t.setStatus(rs.getString("status"));
        t.setApproved(rs.getInt("approved"));
        t.setTherapistDecision(rs.getString("therapist_decision"));
        return t;
    }

    // ================= AVAILABLE SLOTS =================
    public List<String> getAvailableSlots(int therapistId, Date date) throws Exception {
        List<String> allSlots = Arrays.asList(
                "10:00", "11:00", "12:00", "13:00",
                "14:00", "15:00", "16:00", "17:00"
        );

        List<String> bookedSlots = new ArrayList<>();

        String sql = "SELECT appointment_time FROM appointments " +
                     "WHERE therapist_id=? AND appointment_date=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookedSlots.add(rs.getTime("appointment_time").toString().substring(0, 5));
            }
        }

        List<String> freeSlots = new ArrayList<>();
        for (String slot : allSlots) {
            if (!bookedSlots.contains(slot)) {
                freeSlots.add(slot);
            }
        }

        return freeSlots;
    }



    
    public boolean approveTherapist(int id) {
        String sql = "UPDATE therapists SET approved=1, therapist_decision='Approved', status='Active' WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean rejectTherapist(int id) {
        String sql = "UPDATE therapists SET approved=0, therapist_decision='Rejected', status='Inactive' WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addAvailability(TherapistAvailability availability) {
        String sql = "INSERT INTO therapist_availability " +
                     "(therapist_id, available_date, start_time, end_time, slot_duration) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, availability.getTherapistId());
            ps.setDate(2, availability.getAvailableDate());   // java.sql.Date
            ps.setTime(3, availability.getStartTime());       // java.sql.Time
            ps.setTime(4, availability.getEndTime());         // java.sql.Time
            ps.setInt(5, availability.getSlotDuration());     // minutes

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Therapist> getTherapistsBySalon(int salonId) {
        List<Therapist> list = new ArrayList<>();

        String sql = "SELECT * FROM therapists " +
                     "WHERE salon_id=? AND approved=1 AND status='Active' " +
                     "ORDER BY name ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTherapist(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

   

}

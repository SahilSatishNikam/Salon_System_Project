package dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.time.LocalTime;

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

	        ResultSet rs = ps.executeQuery();

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

	            System.out.println("LOGIN FOUND therapist = " + t.getEmail());
	            return t;
	        }
	    }

	    System.out.println("LOGIN FAILED — no therapist row matched");
	    return null;
	}



    // Add therapist
    public boolean addTherapist(Therapist t) {
        String sql = "INSERT INTO therapists (salon_id, name, phone, email, specialty, password, status, approved, therapist_decision) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
        }
        return false;
    }

    // Update therapist
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
        }
        return false;
    }


    // Get therapist by ID
  

    // Update therapist status (Active / Inactive)
    public boolean updateStatus(int therapistId, String status) {
        String sql = "UPDATE therapists SET status=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, therapistId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Approve therapist
   

    // Update therapist decision
    public boolean updateTherapistDecision(int therapistId, String decision) {
        String sql = "UPDATE therapists SET therapist_decision=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, decision);
            ps.setInt(2, therapistId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get therapists by salon
    public List<Therapist> getTherapistsBySalon(int salonId) {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT * FROM therapists WHERE salon_id=? AND status='Active' AND approved=1";

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

    // Helper method to map ResultSet to Therapist object
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
    
    public List<Therapist> getAllTherapists() {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT * FROM therapists ORDER BY id DESC"; // Make sure your table name is correct

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setStatus(rs.getString("status"));
                t.setApproved(rs.getInt("approved"));
                t.setTherapistDecision(rs.getString("therapist_decision"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

 // Approve a therapist
    public boolean updateApproval(int id, int approved) {
        String sql = "UPDATE therapists SET approved=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, approved);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update therapist decision (optional)
    public boolean updateDecision(int id, String decision) {
        String sql = "UPDATE therapists SET therapist_decision=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, decision);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Therapist> getTherapistsByService(int serviceId) {
        List<Therapist> list = new ArrayList<>();
        String sql = "SELECT t.* " +
                     "FROM therapists t " +
                     "JOIN salons s ON t.salon_id = s.id " +
                     "JOIN services srv ON srv.salon_id = s.id " +
                     "WHERE srv.id = ? AND t.approved = 1 AND t.status = 'Active'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setSalonId(rs.getInt("salon_id"));
                t.setStatus(rs.getString("status"));
                t.setApproved(rs.getInt("approved"));
                t.setTherapistDecision(rs.getString("therapist_decision"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
  
 // Approve Therapist
    public boolean approveTherapist(int id) {
        String sql = "UPDATE therapists SET approved = 1, status = 'Active', therapist_decision = 'APPROVED' WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate(); // must execute the update
            return rows > 0; // returns true if at least 1 row updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Reject Therapist
    public void rejectTherapist(int id) {
        String sql = "UPDATE therapist SET approved = 0, status = 'Inactive', therapistDecision = 'REJECTED' WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete Therapist
    public void deleteTherapist(int id) {
        String sql = "DELETE FROM therapist WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get therapist by ID
    public Therapist getTherapistById(int id) {
        Therapist t = null;
        String sql = "SELECT * FROM therapist WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                t = new Therapist();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setPhone(rs.getString("phone"));
                t.setEmail(rs.getString("email"));
                t.setSpecialty(rs.getString("specialty"));
                t.setSalonId(rs.getInt("salonId"));
                t.setPassword(rs.getString("password"));
                t.setApproved(rs.getInt("approved"));
                t.setStatus(rs.getString("status"));
                t.setTherapistDecision(rs.getString("therapistDecision"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    

    public boolean addAvailability(TherapistAvailability availability) {
        boolean success = false;
        String sql = "INSERT INTO availability (therapist_id, available_date, slot_start, slot_end) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Generate slots based on slotDuration
            long startMillis = availability.getStartTime().getTime();
            long endMillis = availability.getEndTime().getTime();
            int duration = availability.getSlotDuration() * 60 * 1000; // convert minutes to milliseconds

            List<PreparedStatement> batchList = new ArrayList<>();

            while (startMillis + duration <= endMillis) {
                java.sql.Time slotStart = new java.sql.Time(startMillis);
                java.sql.Time slotEnd = new java.sql.Time(startMillis + duration);

                ps.setInt(1, availability.getTherapistId());
                ps.setDate(2, availability.getAvailableDate());
                ps.setTime(3, slotStart);
                ps.setTime(4, slotEnd);
                ps.addBatch();

                startMillis += duration; // move to next slot
            }

            int[] results = ps.executeBatch();
            success = results.length > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public List<String> getAvailableSlots(int therapistId, java.sql.Date date) {

        List<String> slots = new ArrayList<>();

        String sql = """
            SELECT start_time
            FROM therapist_availability
            WHERE therapist_id=? 
            AND available_date=?
            ORDER BY start_time
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                slots.add(rs.getTime("start_time")
                            .toLocalTime()
                            .toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return slots;
    }

}
    


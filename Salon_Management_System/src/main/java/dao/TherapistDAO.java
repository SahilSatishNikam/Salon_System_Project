package dao;

import java.sql.*;
import java.sql.Date;
import java.time.LocalTime;
import java.util.*;
import model.Therapist;
import util.DBConnection;

public class TherapistDAO {

    // Therapist login
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
        return null;
    }

    // Add therapist
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
            ps.setString(7, "Active");
            ps.setInt(8, 0); // default not approved

            return ps.executeUpdate() > 0;
        }
    }

    // Approve therapist
    public boolean approveTherapist(int therapistId) throws Exception {
        String sql = "UPDATE therapists SET approved=1 WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            return ps.executeUpdate() > 0;
        }
    }

    // Update therapist decision
    public void updateTherapistDecision(int id, String decision) {
        String sql = "UPDATE therapists SET therapist_decision=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, decision);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get therapist by ID
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

    // Get all therapists
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

    // Get therapists by salon
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

    // Add availability
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

    // Check therapist availability for a time slot
    public boolean isTherapistAvailable(int therapistId, Date date, Time time) throws Exception {
        String sql = "SELECT * FROM therapist_availability WHERE therapist_id=? AND available_date=? AND start_time <= ? AND end_time >= ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ps.setTime(3, time);
            ps.setTime(4, time);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Get available slots for a therapist on a specific day
    public List<String> getAvailableSlots(int therapistId, Date date) throws Exception {
        List<String> slots = new ArrayList<>();
        String availQuery = "SELECT start_time, end_time FROM therapist_availability WHERE therapist_id=? AND available_date=?";
        String bookedQuery = "SELECT appointment_time FROM appointments WHERE therapist_id=? AND appointment_date=? AND status IN ('Pending','Confirmed','Booked')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement psAvail = con.prepareStatement(availQuery);
             PreparedStatement psBooked = con.prepareStatement(bookedQuery)) {

            psAvail.setInt(1, therapistId);
            psAvail.setDate(2, date);
            ResultSet rsAvail = psAvail.executeQuery();

            List<Time[]> ranges = new ArrayList<>();
            while (rsAvail.next()) {
                ranges.add(new Time[]{rsAvail.getTime("start_time"), rsAvail.getTime("end_time")});
            }

            if (ranges.isEmpty()) return slots;

            psBooked.setInt(1, therapistId);
            psBooked.setDate(2, date);
            ResultSet rsBooked = psBooked.executeQuery();

            Set<LocalTime> booked = new HashSet<>();
            while (rsBooked.next()) {
                booked.add(rsBooked.getTime("appointment_time").toLocalTime());
            }

            for (Time[] range : ranges) {
                LocalTime start = range[0].toLocalTime();
                LocalTime end = range[1].toLocalTime();

                while (!start.isAfter(end.minusMinutes(30))) {
                    if (!booked.contains(start)) slots.add(start.toString());
                    start = start.plusMinutes(30);
                }
            }
        }
        return slots;
    }

    // Check if a specific slot is booked
    public boolean isSlotBooked(int therapistId, Date date, Time time) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE therapist_id=? AND appointment_date=? AND slot_time=? AND status!='CANCELLED'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ps.setTime(3, time);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get number of completed appointments per therapist
    public Map<String, Integer> getAppointmentsCountPerTherapist() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT t.name, COUNT(a.id) as count " +
                     "FROM therapists t " +
                     "LEFT JOIN appointments a ON t.id = a.therapist_id AND a.status='completed' " +
                     "GROUP BY t.name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getString("name"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // Get therapists by service
    public List<Therapist> getTherapistsByService(int serviceId) {
        List<Therapist> therapists = new ArrayList<>();
        String sql = "SELECT t.id, t.name, t.specialty FROM therapists t " +
                     "JOIN therapist_services ts ON t.id = ts.therapist_id " +
                     "WHERE ts.service_id=? AND t.status='Active'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Therapist t = new Therapist();
                    t.setId(rs.getInt("id"));
                    t.setName(rs.getString("name"));
                    t.setSpecialty(rs.getString("specialty"));
                    therapists.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return therapists;
    }
    
    public void updateStatus(int therapistId, String status) {
        String sql = "UPDATE therapists SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, therapistId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

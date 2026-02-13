package dao;

import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import model.TherapistAvailability;
import util.DBConnection;


public class TherapistAvailabilityDAO {

	public boolean addAvailability(TherapistAvailability availability) throws Exception {
        String sql = "INSERT INTO therapist_availability (therapist_id, available_date, start_time, end_time, slot_duration) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, availability.getTherapistId());
            ps.setDate(2, availability.getAvailableDate());
            ps.setTime(3, availability.getStartTime());
            ps.setTime(4, availability.getEndTime());
            ps.setInt(5, availability.getSlotDuration());

            return ps.executeUpdate() > 0;
        }
	}

    public TherapistAvailability getByTherapistDate(int therapistId, Date date) {

        String sql = "SELECT * FROM therapist_availability " +
                     "WHERE therapist_id=? AND available_date=?";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                TherapistAvailability a = new TherapistAvailability();
                a.setId(rs.getInt("id"));
                a.setTherapistId(therapistId);
                a.setAvailableDate(date);
                a.setStartTime(rs.getTime("start_time"));
                a.setEndTime(rs.getTime("end_time"));
                a.setSlotDuration(rs.getInt("slot_duration"));
                return a;
            }

        } catch(Exception e){ e.printStackTrace(); }

        return null;
    }
    
    public List<TherapistAvailability> getAllFutureByTherapist(int therapistId) {

        List<TherapistAvailability> list = new ArrayList<>();

        String sql = "SELECT * FROM therapist_availability " +
                     "WHERE therapist_id=? AND available_date >= CURDATE() " +
                     "ORDER BY available_date, start_time";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                TherapistAvailability a = new TherapistAvailability();
                a.setId(rs.getInt("id"));
                a.setTherapistId(rs.getInt("therapist_id"));
                a.setAvailableDate(rs.getDate("available_date"));
                a.setStartTime(rs.getTime("start_time"));
                a.setEndTime(rs.getTime("end_time"));
                a.setSlotDuration(rs.getInt("slot_duration"));

                list.add(a);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    private TherapistAvailability mapRow(ResultSet rs) throws SQLException {

        TherapistAvailability a = new TherapistAvailability();
        a.setId(rs.getInt("id"));
        a.setTherapistId(rs.getInt("therapist_id"));
        a.setAvailableDate(rs.getDate("available_date"));
        a.setStartTime(rs.getTime("start_time"));
        a.setEndTime(rs.getTime("end_time"));
        a.setSlotDuration(rs.getInt("slot_duration"));

        return a;
    }
    
    public List<TherapistAvailability> getUpcomingAvailability(int therapistId) {

        List<TherapistAvailability> list = new ArrayList<>();

        String sql = "SELECT * FROM therapist_availability " +
                     "WHERE therapist_id=? AND available_date >= CURDATE() " +
                     "ORDER BY available_date, start_time";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TherapistAvailability a = new TherapistAvailability();
                a.setId(rs.getInt("id"));
                a.setTherapistId(rs.getInt("therapist_id"));
                a.setAvailableDate(rs.getDate("available_date"));
                a.setStartTime(rs.getTime("start_time"));
                a.setEndTime(rs.getTime("end_time"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    public List<String> getAvailableSlots(int therapistId, Date date) throws Exception {
        List<String> slots = new ArrayList<>();

        String sql = "SELECT start_time, end_time, slot_duration FROM therapist_availability " +
                     "WHERE therapist_id=? AND available_date=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LocalTime start = rs.getTime("start_time").toLocalTime();
                LocalTime end = rs.getTime("end_time").toLocalTime();
                int duration = rs.getInt("slot_duration");

                // 🛑 skip invalid ranges
                if (end.isBefore(start)) continue;

                while (start.plusMinutes(duration).isBefore(end.plusSeconds(1))) {
                    slots.add(start.toString()); // HH:mm
                    start = start.plusMinutes(duration);
                }
            }
        }
        return slots;
    }

}

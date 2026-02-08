package dao;

import java.sql.*;
import model.TherapistAvailability;
import util.DBConnection;
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
}

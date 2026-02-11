package dao;

import model.Slot;
import java.sql.*;
import java.util.*;
import util.DBConnection;

public class SlotDAO {

    public List<Slot> getSlotsByTherapist(int therapistId) {

        List<Slot> list = new ArrayList<>();

        try(Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM therapist_availability " +
                         "WHERE therapist_id=? " +
                         "ORDER BY available_date, start_time";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Slot s = new Slot();
                s.setId(rs.getInt("id"));
                s.setTherapistId(rs.getInt("therapist_id"));
                s.setAvailableDate(rs.getDate("available_date"));
                s.setStartTime(rs.getTime("start_time"));
                s.setEndTime(rs.getTime("end_time"));
                s.setSlotDuration(rs.getInt("slot_duration"));

                list.add(s);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}

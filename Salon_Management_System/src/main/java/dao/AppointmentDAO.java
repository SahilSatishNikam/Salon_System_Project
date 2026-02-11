package dao;

import java.sql.*;
import java.sql.Date;
import java.time.LocalTime;
import java.util.*;
import model.Appointment;
import model.Slot;
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
            
         
        }
        catch(Exception e){
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

        // ✅ ADD THESE (missing in your code)
        a.setCustomerName(rs.getString("customerName"));
        a.setFeedbackGiven(rs.getBoolean("feedback_given"));

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
            AND status = 'COMPLETED'
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

    public Appointment getAppointmentById(int appointmentId) {
        Appointment appt = null;

        String sql = "SELECT * FROM appointments WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    appt = new Appointment();
                    appt.setId(rs.getInt("id"));
                    appt.setUserId(rs.getInt("user_id"));
                    appt.setSalonId(rs.getInt("salon_id"));
                    appt.setTherapistId(rs.getInt("therapist_id"));
                    appt.setServiceName(rs.getString("service_name"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setAppointmentTime(rs.getTime("appointment_time"));
                    appt.setStatus(rs.getString("status"));
                    appt.setTherapistDecision(rs.getString("therapist_decision"));

                    // These are for client creation
                    appt.setCustomerName(rs.getString("customer_name")); // assuming your appointments table has this
                    appt.setPhone(rs.getString("phone"));               // assuming your appointments table has this
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appt;
    }


    public boolean rescheduleAppointment(int appointmentId, java.sql.Date newDate, java.sql.Time newTime) {
        boolean success = false;

        String sql = "UPDATE appointments SET appointment_date=?, appointment_time=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, newDate);
            ps.setTime(2, newTime);
            ps.setInt(3, appointmentId);

            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public List<String> getBookedSlots(int therapistId, String date) {
        List<String> slots = new ArrayList<>();
        String sql = "SELECT appointment_time FROM appointments " +
                     "WHERE therapist_id=? AND appointment_date=?";

<<<<<<< Updated upstream
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, Date.valueOf(date)); // convert string to java.sql.Date

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Time time = rs.getTime("appointment_time");
                slots.add(time.toLocalTime().toString()); // convert Time -> HH:mm string
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return slots;
    }

    // -------------------------------
    // 2️⃣ Check if a specific slot is already booked
    // -------------------------------
    public boolean isSlotAlreadyBooked(int therapistId, String date, String time) {
        String sql = "SELECT 1 FROM appointments " +
                     "WHERE therapist_id=? AND appointment_date=? AND appointment_time=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, Date.valueOf(date));
            ps.setTime(3, Time.valueOf(time + ":00")); // convert "HH:mm" to Time

            ResultSet rs = ps.executeQuery();
            return rs.next(); // true if slot exists

        } catch (Exception e) {
            e.printStackTrace();
            return true; // assume booked if error occurs
        }
    }

    // -------------------------------
    // 3️⃣ Insert a new appointment into the database
    // -------------------------------
    public void insertAppointment(int userId, int therapistId, int salonId,
                                  String serviceName, String date, String time,
                                  String customerName) {
        String sql = "INSERT INTO appointments " +
                     "(user_id, therapist_id, salon_id, service_name, " +
                     "appointment_date, appointment_time, customerName) " +
                     "VALUES (?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, therapistId);
            ps.setInt(3, salonId);
            ps.setString(4, serviceName);
            ps.setDate(5, Date.valueOf(date));
            ps.setTime(6, Time.valueOf(time + ":00")); // convert HH:mm -> Time
            ps.setString(7, customerName);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Appointment> getAvailableSlotsByTherapist(int therapistId) {
        List<Appointment> slots = new ArrayList<>();

        String sql = "SELECT * FROM appointments WHERE therapist_id=? AND status='available' ORDER BY appointment_time";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = new Appointment();

                    a.setId(rs.getInt("id"));
                    a.setAppointmentDate(rs.getDate("appointment_date"));   // DB Date
                    a.setAppointmentTime(rs.getTime("appointment_time"));   // DB Time
                    a.setServiceName(rs.getString("service_name"));
                    a.setStatus(rs.getString("status"));

                    // For display purposes
                    a.setDate(rs.getDate("appointment_date").toString());
                    a.setTime(rs.getTime("appointment_time").toString());

                    slots.add(a);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return slots;
    }

    
    public List<Appointment> getAvailableSlotsByTherapistAndDate(int therapistId, java.sql.Date date) {
        List<Appointment> slots = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE therapist_id=? AND appointment_date=? AND status='available' ORDER BY appointment_time";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setDate(2, date);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = new Appointment();

                    a.setId(rs.getInt("id"));
                    a.setAppointmentDate(rs.getDate("appointment_date"));
                    a.setAppointmentTime(rs.getTime("appointment_time"));
                    a.setServiceName(rs.getString("service_name"));
                    a.setStatus(rs.getString("status"));

                    // Populate display fields
                    a.setDate(rs.getDate("appointment_date").toString());
                    a.setTime(rs.getTime("appointment_time").toString());

                    slots.add(a);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return slots;
    }

    
    public List<String> getAvailableSlots(int therapistId, java.sql.Date date) {
        List<String> slots = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // 1️⃣ Get therapist availability for the date
            String availQuery = "SELECT start_time, end_time, slot_duration FROM therapist_availability WHERE therapist_id=? AND available_date=?";
            PreparedStatement ps = conn.prepareStatement(availQuery);
            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();

            if(!rs.next()) return slots; // No availability

            Time startTime = rs.getTime("start_time");
            Time endTime = rs.getTime("end_time");
            int duration = rs.getInt("slot_duration"); // in minutes

            // 2️⃣ Generate all slots between start and end
            LocalTime start = startTime.toLocalTime();
            LocalTime end = endTime.toLocalTime();

            List<String> allSlots = new ArrayList<>();
            while(start.plusMinutes(duration).compareTo(end) <= 0){
                allSlots.add(start.toString());
                start = start.plusMinutes(duration);
            }

            // 3️⃣ Remove already booked slots
            String bookedQuery = "SELECT appointment_time FROM user_appointments WHERE therapist_id=? AND appointment_date=?";
            ps = conn.prepareStatement(bookedQuery);
            ps.setInt(1, therapistId);
            ps.setDate(2, date);
            rs = ps.executeQuery();

            List<String> bookedSlots = new ArrayList<>();
            while(rs.next()){
                bookedSlots.add(rs.getTime("appointment_time").toLocalTime().toString());
            }

            for(String slot : allSlots){
                if(!bookedSlots.contains(slot)) slots.add(slot);
=======
    public double getTotalRevenue() {
        double revenue = 0;
        String sql = "SELECT SUM(price) as total FROM appointments WHERE status='completed'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                revenue = rs.getDouble("total");
>>>>>>> Stashed changes
            }

        } catch(Exception e){
            e.printStackTrace();
        }
<<<<<<< Updated upstream

        return slots;
    }



}
=======
        return revenue;
    }
    public List<Appointment> getAppointmentsBySlot(Slot slot) { 
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE therapist_id=? AND appointment_date=? AND appointment_time BETWEEN ? AND ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, slot.getTherapistId());
            ps.setDate(2, new java.sql.Date(slot.getAvailableDate().getTime())); // if Date
            ps.setTime(3, new java.sql.Time(slot.getStartTime().getTime()));       // if java.util.Date
            ps.setTime(4, new java.sql.Time(slot.getEndTime().getTime()));

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Appointment a = new Appointment();
                a.setCustomerName(rs.getString("customerName")); // <-- FIXED
                a.setServiceName(rs.getString("service_name"));
                a.setStatus(rs.getString("status"));
                a.setAppointmentTime(rs.getTime("appointment_time"));
                list.add(a);
            }
        } catch(Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }


    
 }
>>>>>>> Stashed changes



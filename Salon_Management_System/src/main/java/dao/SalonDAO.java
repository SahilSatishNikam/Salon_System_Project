package dao;

import java.sql.*;
import java.util.*;
import model.Salon;
import util.DBConnection;

public class SalonDAO {

	    public void addSalon(Salon s) throws Exception {
	        String sql = "INSERT INTO salons(name,email,phone,address,image,status,created_at) " +
	                     "VALUES (?,?,?,?,?, 'Pending', NOW())";

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, s.getName());
	            ps.setString(2, s.getEmail());
	            ps.setString(3, s.getPhone());
	            ps.setString(4, s.getAddress());
	            ps.setBytes(5, s.getImage());
	            ps.executeUpdate();
	        }
	    }

	    public void deleteSalon(int id) throws Exception {
	        try (Connection con = DBConnection.getConnection()) {
	            con.setAutoCommit(false);

	            try (PreparedStatement ps1 = con.prepareStatement(
	                         "DELETE FROM services WHERE salon_id=?");
	                 PreparedStatement ps2 = con.prepareStatement(
	                         "DELETE FROM salons WHERE id=?")) {

	                ps1.setInt(1, id);
	                ps1.executeUpdate();

	                ps2.setInt(1, id);
	                ps2.executeUpdate();

	                con.commit();
	            } catch (Exception e) {
	                con.rollback();
	                throw e;
	            }
	        }
	    }

	    public void updateStatus(int id, String status) throws Exception {
	        String sql = "UPDATE salons SET status=? WHERE id=?";
	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setString(1, status);
	            ps.setInt(2, id);
	            ps.executeUpdate();
	        }
	    }

	    public List<Salon> getAllSalons() throws Exception {
	        List<Salon> list = new ArrayList<>();
	        String sql = "SELECT * FROM salons ORDER BY created_at DESC";

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                list.add(mapRowToSalon(rs));
	            }
	        }
	        return list;
	    }

	    public Salon getSalonById(int id) throws Exception {
	        String sql = "SELECT * FROM salons WHERE id=?";
	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setInt(1, id);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) return mapRowToSalon(rs);
	            }
	        }
	        return null;
	    }

	    public List<Salon> searchSalons(String name, String location, Integer serviceId) throws Exception {
	        List<Salon> list = new ArrayList<>();
	        StringBuilder sql = new StringBuilder("SELECT * FROM salons WHERE 1=1");

	        if (name != null && !name.trim().isEmpty())
	            sql.append(" AND name LIKE ?");
	        if (location != null && !location.trim().isEmpty())
	            sql.append(" AND address LIKE ?");
	        if (serviceId != null)
	            sql.append(" AND id IN (SELECT salon_id FROM services WHERE id = ?)");

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql.toString())) {

	            int idx = 1;
	            if (name != null && !name.trim().isEmpty())
	                ps.setString(idx++, "%" + name + "%");
	            if (location != null && !location.trim().isEmpty())
	                ps.setString(idx++, "%" + location + "%");
	            if (serviceId != null)
	                ps.setInt(idx++, serviceId);

	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                list.add(mapRowToSalon(rs));
	            }
	        }
	        return list;
	    }

	    private Salon mapRowToSalon(ResultSet rs) throws SQLException {
	        Salon s = new Salon();
	        s.setId(rs.getInt("id"));
	        s.setName(rs.getString("name"));
	        s.setEmail(rs.getString("email"));
	        s.setPhone(rs.getString("phone"));
	        s.setAddress(rs.getString("address"));
	        s.setImage(rs.getBytes("image"));
	        s.setCreated_at(rs.getString("created_at"));
	        s.setStatus(rs.getString("status"));
	        return s;
	    }
	    
	    public int getTotalSalons() {
	        int count = 0;
	        String sql = "SELECT COUNT(*) FROM salons";
	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {
	            if(rs.next()) count = rs.getInt(1);
	        } catch(Exception e) { e.printStackTrace(); }
	        return count;
	    }

	    public Salon getById(int salonId) {
	        Salon salon = null;
	        String sql = "SELECT * FROM salons WHERE id = ?";

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setInt(1, salonId);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                salon = new Salon();
	                salon.setId(rs.getInt("id"));
	                salon.setName(rs.getString("name"));
	                salon.setAddress(rs.getString("address"));
	                salon.setPhone(rs.getString("phone"));
	                salon.setEmail(rs.getString("email"));
	                // add any other Salon fields from your DB
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return salon;
	    }
	}


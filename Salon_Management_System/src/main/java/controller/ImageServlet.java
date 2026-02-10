package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ImageServlet
 */
@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps =
              con.prepareStatement("SELECT profile_photo FROM users WHERE id=?");

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                byte[] img = rs.getBytes("profile_photo");

                if(img != null){
                    resp.setContentType("image/jpeg");
                    resp.getOutputStream().write(img);
                }
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}

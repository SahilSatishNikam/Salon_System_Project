package controller;

import java.io.IOException;
import java.io.InputStream;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;

@WebServlet("/UploadProfileImageServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class UploadProfileImageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Part photo = req.getPart("photo");
        InputStream is = photo.getInputStream();

        try {
			new UserDAO().updateUserImage(user.getId(), is);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        resp.sendRedirect("profile.jsp?success=Profile updated successfully");
    }
}
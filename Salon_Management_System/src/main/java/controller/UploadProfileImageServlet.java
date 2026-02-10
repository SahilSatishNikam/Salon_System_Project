package controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

import dao.UserDAO;
import model.User;

@MultipartConfig
@WebServlet("/UploadProfileImageServlet")
public class UploadProfileImageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if(user == null){
            resp.sendRedirect("login.jsp");
            return;
        }

        Part filePart = req.getPart("photo");
        InputStream is = filePart.getInputStream();

        UserDAO dao = new UserDAO();
        dao.updateProfilePhoto(user.getId(), is);

        resp.sendRedirect("profile.jsp?success=Photo uploaded");
    }
}


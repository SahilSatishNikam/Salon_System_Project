package controller;

import java.io.IOException;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Email regex
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    // Phone regex (10 digits)
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10}$");

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        // Trim
        if(name!=null) name=name.trim();
        if(email!=null) email=email.trim();
        if(phone!=null) phone=phone.trim();

        String error = null;

        /* ========= VALIDATION ========= */

        // Name
        if(name==null || name.length()<3){
            error="Name must be at least 3 characters";
        }

        // Email
        else if(email==null || !EMAIL_PATTERN.matcher(email).matches()){
            error="Invalid email format";
        }

        // Password
        else if(password==null || password.length()<6){
            error="Password must be at least 6 characters";
        }

        // Phone
        else if(phone!=null && !phone.isEmpty() &&
                !PHONE_PATTERN.matcher(phone).matches()){
            error="Phone must be 10 digits";
        }

        if(error!=null){
            res.sendRedirect("register.jsp?error="+error);
            return;
        }

        /* ========= REGISTER ========= */

        try {

            UserDAO userDAO = new UserDAO();

            // check duplicate email
            if(userDAO.emailExists(email)){
                res.sendRedirect("register.jsp?error=Email already exists");
                return;
            }

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);

            boolean ok = userDAO.registerUser(user);

            if(ok){
                res.sendRedirect("login.jsp?msg=Registration Successful");
            }else{
                res.sendRedirect("register.jsp?error=Registration Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=Server Error");
        }
    }
}

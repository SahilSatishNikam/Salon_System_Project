package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import dao.SalonDAO;
import model.Salon;

@WebServlet("/AddSalonServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,       // 1MB
    maxFileSize = 1024 * 1024 * 20,        // 20MB per file
    maxRequestSize = 1024 * 1024 * 25      // 25MB total
)
public class AddSalonServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Part filePart = request.getPart("image");
        byte[] imageBytes = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream is = filePart.getInputStream()) {
                imageBytes = is.readAllBytes();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("manage-salons.jsp?error=Failed+to+read+image");
                return;
            }
        } else {
            response.sendRedirect("manage-salons.jsp?error=Please+select+an+image");
            return;
        }

        try {
            Salon salon = new Salon();
            salon.setName(name);
            salon.setEmail(email);
            salon.setPhone(phone);
            salon.setAddress(address);
            salon.setImage(imageBytes);

            new SalonDAO().addSalon(salon);
            response.sendRedirect("manage-salons.jsp?success=Salon+added");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-salons.jsp?error=Something+went+wrong");
        }
    }
}
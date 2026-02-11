package controller;

import dao.SalonDAO;
import model.Salon;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/EditSalonServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // max 5MB
public class EditSalonServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if(idParam == null || idParam.isEmpty()){
            response.sendRedirect("manage-salons.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);
        SalonDAO dao = new SalonDAO();
        Salon salon = dao.getSalonById(id);

        if(salon == null){
            response.sendRedirect("manage-salons.jsp");
            return;
        }

        request.setAttribute("salon", salon);
        request.getRequestDispatcher("edit-salon.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // handle special characters

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Handle image file
        Part filePart = request.getPart("image");
        InputStream imageStream = null;
        if(filePart != null && filePart.getSize() > 0){
            imageStream = filePart.getInputStream();
        }

        SalonDAO dao = new SalonDAO();
        boolean updated = dao.updateSalon(id, name, email, phone, address, imageStream);

        if(updated){
            response.sendRedirect("manage-salons.jsp");
        } else {
            request.setAttribute("error", "Failed to update salon.");
            doGet(request, response);
        }
    }
}

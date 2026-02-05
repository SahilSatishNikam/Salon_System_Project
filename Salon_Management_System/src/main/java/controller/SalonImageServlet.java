package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.SalonDAO;
import model.Salon;

@WebServlet("/SalonImageServlet")
public class SalonImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Salon salon = new SalonDAO().getSalonById(id);

            if (salon != null && salon.getImage() != null) {
                response.setContentType("image/jpeg");
                OutputStream os = response.getOutputStream();
                InputStream is = new ByteArrayInputStream(salon.getImage());
                byte[] buffer = new byte[1024];
                int len;
                while ((len = is.read(buffer)) != -1) os.write(buffer, 0, len);
                is.close(); os.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

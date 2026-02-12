package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import dao.TherapistDAO;
import dao.SalonDAO;
import model.Salon;
import model.Therapist;

@WebServlet("/AdminTherapistServlet")
public class AdminTherapistServlet extends HttpServlet {
    
    private TherapistDAO therapistDao = new TherapistDAO();
    private SalonDAO salonDao = new SalonDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        try {
            if (action != null && idParam != null) {
                int id = Integer.parseInt(idParam);

                switch (action) {
                    case "edit":
                        Therapist editTherapist = therapistDao.getTherapistById(id);
                        request.setAttribute("editTherapist", editTherapist);
                        break;

                    case "delete":
                        therapistDao.deleteTherapist(id);
                        break;

                    case "approve":
                        therapistDao.approveTherapist(id);
                        break;

                    case "reject":
                        therapistDao.rejectTherapist(id);
                        break;
                }
            }

            // Load all therapists and salons
            List<Therapist> therapists = therapistDao.getAllTherapists();
            request.setAttribute("therapists", therapists);

            List<Salon> salons = salonDao.getAllSalons();
            request.setAttribute("salons", salons);

            // Forward to JSP once at the end
            request.getRequestDispatcher("admin-therapists.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Server+Error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action) || "update".equals(action)) {
                int id = 0;
                if ("update".equals(action)) {
                    id = Integer.parseInt(request.getParameter("id"));
                }

                Therapist t = new Therapist();
                t.setName(request.getParameter("name"));
                t.setPhone(request.getParameter("phone"));
                t.setEmail(request.getParameter("email"));
                t.setSpecialty(request.getParameter("specialty"));
                t.setSalonId(Integer.parseInt(request.getParameter("salonId")));
                t.setPassword(request.getParameter("password"));

                if ("add".equals(action)) {
                    therapistDao.addTherapist(t);
                } else {
                    t.setId(id);
                    therapistDao.updateTherapist(t);
                }
            }

            response.sendRedirect("AdminTherapistServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Server+Error");
        }
    }
}

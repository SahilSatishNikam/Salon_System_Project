package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Therapist;

import java.io.IOException;
import java.util.List;

import dao.TherapistDAO;

/**
 * Servlet implementation class GetTherapistsByServiceServlet
 */
@WebServlet("/GetTherapistsByServiceServlet")
public class GetTherapistsByServiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));
            TherapistDAO dao = new TherapistDAO();
            List<Therapist> therapists = dao.getTherapistsByService(serviceId);

            StringBuilder sb = new StringBuilder();
            sb.append("<option value=''>-- Select Therapist --</option>");
            for(Therapist t : therapists){
                sb.append("<option value='").append(t.getId()).append("'>")
                  .append(t.getName()).append(" - ").append(t.getSpecialty())
                  .append("</option>");
            }

            resp.setContentType("text/html");
            resp.getWriter().write(sb.toString());

        } catch(Exception e){
            e.printStackTrace();
            resp.setStatus(500);
        }
    }
}

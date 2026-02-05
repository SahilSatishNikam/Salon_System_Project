<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Appointment, dao.AppointmentDAO, model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    List<Appointment> list = dao.getAppointmentsByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback & Ratings | SalonEase</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/feedback.css">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<div class="feedback-container">

    <h1>⭐ Rate Your Experience</h1>
    <p class="subtitle">Help others discover the best salons ✨</p>

    <div class="feedback-list">

        <% if(list.isEmpty()) { %>
            <div class="empty">
                No appointments yet ✨ Book your first service and share your experience!
            </div>
        <% } else {
            for(Appointment a : list) {
        %>

        <div class="feedback-card">
            <div class="card-left">
                <h3>Appointment #<%= a.getId() %></h3>
                <p><i class="fa-solid fa-scissors"></i> <%= a.getServiceName() %></p>
                <p><i class="fa-solid fa-calendar-days"></i> <%= a.getAppointmentDate() %></p>
                <p><i class="fa-solid fa-circle-check"></i> Status: <%= a.getStatus() %></p>
            </div>

            <div class="card-right">
                <% if(!a.isFeedbackGiven()) { %>
                <form action="FeedbackServlet" method="post" class="feedback-form">
                    <input type="hidden" name="appointmentId" value="<%= a.getId() %>">

                    <div class="stars">
                        <input type="radio" name="rating" value="5" id="star5-<%= a.getId() %>"><label for="star5-<%= a.getId() %>">★</label>
                        <input type="radio" name="rating" value="4" id="star4-<%= a.getId() %>"><label for="star4-<%= a.getId() %>">★</label>
                        <input type="radio" name="rating" value="3" id="star3-<%= a.getId() %>"><label for="star3-<%= a.getId() %>">★</label>
                        <input type="radio" name="rating" value="2" id="star2-<%= a.getId() %>"><label for="star2-<%= a.getId() %>">★</label>
                        <input type="radio" name="rating" value="1" id="star1-<%= a.getId() %>"><label for="star1-<%= a.getId() %>">★</label>
                    </div>

                    <textarea name="comment" placeholder="Write your experience..." required></textarea>

                    <button type="submit">Submit Feedback</button>
                </form>
                <% } else { %>
                    <span class="given">✔ Feedback Submitted</span>
                <% } %>
            </div>
        </div>

        <% }} %>

    </div>

</div>

</body>
</html>
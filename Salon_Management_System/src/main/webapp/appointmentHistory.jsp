<%@ page import="java.util.*, dao.*, model.*" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) response.sendRedirect("login.jsp");

    List<Appointment> history = new AppointmentDAO().getAppointmentHistory(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Appointment History</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
<h3>Appointment History</h3>
<table class="table table-striped mt-3">
  <thead>
    <tr>
      <th>Service</th>
      <th>Therapist</th>
      <th>Date</th>
      <th>Time</th>
      <th>Status</th>
      <th>Feedback</th>
    </tr>
  </thead>
  <tbody>
    <% for(Appointment a : history) {
         Service s = new ServiceDAO().getServiceById(a.getServiceId());
         Therapist t = new TherapistDAO().getTherapistById(a.getTherapistId());
    %>
    <tr>
      <td><%= s.getName() %></td>
      <td><%= t.getName() %></td>
      <td><%= a.getAppointmentDate() %></td>
      <td><%= a.getAppointmentTime() %></td>
      <td><%= a.getStatus() %></td>
      <td>
        <% if(a.getStatus().equals("Completed")) { %>
          <a href="feedback.jsp?appointmentId=<%= a.getId() %>" class="btn btn-sm btn-success">Give Feedback</a>
        <% } else { %>
          <span class="text-muted">N/A</span>
        <% } %>
      </td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>
</body>
</html>

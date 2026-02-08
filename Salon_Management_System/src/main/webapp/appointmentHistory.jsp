<%@ page import="java.util.*, model.*" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> history = (List<Appointment>) request.getAttribute("history");
    Map<Integer, Salon> salons = (Map<Integer, Salon>) request.getAttribute("salonsMap");
    Map<Integer, Therapist> therapists = (Map<Integer, Therapist>) request.getAttribute("therapistsMap");
    if(history == null) history = new ArrayList<>();
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
      <th>Salon</th>
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
        Salon s = salons.get(a.getSalonId());
        Therapist t = therapists.get(a.getTherapistId());
    %>
    <tr>
      <td><%= s != null ? s.getName() : "Unknown" %></td>
      <td><%= a.getServiceName() %></td>
      <td><%= t != null ? t.getName() : "Unknown" %></td>
      <td><%= a.getAppointmentDate() %></td>
      <td><%= a.getAppointmentTime() %></td>
      <td><%= a.getStatus() %></td>
      <td>
        <% if("Completed".equalsIgnoreCase(a.getStatus())) { %>
          <a href="feedback.jsp?appointmentId=<%= a.getId() %>" class="btn btn-sm btn-success">Give Feedback</a>
        <% } else { %>
          <span class="text-muted">N/A</span>
        <% } %>
      </td>
    </tr>
    <% } %>
  </tbody>
</table>

<a href="user-dashboard.jsp" class="btn btn-secondary mt-3">← Back to Dashboard</a>
</div>
</body>
</html>

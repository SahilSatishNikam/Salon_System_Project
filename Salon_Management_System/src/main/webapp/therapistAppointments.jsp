<%@ page import="java.util.*, model.*" %>
<%@ page session="true" %>
<%
    Therapist therapist = (Therapist) session.getAttribute("therapist");
    if(therapist == null){
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    if(appointments == null) appointments = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Therapist Appointments</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
<h3>Appointments for <%= therapist.getName() %></h3>

<table class="table table-striped mt-3">
<thead>
<tr>
    <th>Service</th>
    <th>Customer</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Decision</th>
    <th>Action</th>
</tr>
</thead>
<tbody>

<% for(Appointment a : appointments) { %>
<tr>
    <td><%= a.getServiceName() %></td>
    <td><%= a.getCustomerName() %></td>
    <td><%= a.getAppointmentDate() %></td>
    <td><%= a.getAppointmentTime() %></td>
    <td><%= a.getStatus() %></td>
    <td><%= a.getTherapistDecision() %></td>

    <td>
    <form method="post" action="TherapistAppointmentServlet">

        <input type="hidden" name="id" value="<%= a.getId() %>">

        <%-- BOOKED → show Start --%>
        <% if("BOOKED".equalsIgnoreCase(a.getStatus())) { %>

            <button type="submit" name="action" value="start" class="btn btn-success btn-sm">
                Start
            </button>

        <%-- IN_PROGRESS → show Complete --%>
        <% } else if("IN_PROGRESS".equalsIgnoreCase(a.getStatus())) { %>

            <button type="submit" name="action" value="complete" class="btn btn-primary btn-sm">
                Complete
            </button>

        <%-- COMPLETED --%>
        <% } else { %>
            <span class="text-muted">No actions</span>
        <% } %>

    </form>
    </td>

</tr>
<% } %>

</tbody>
</table>

<a href="therapistDashboard.jsp" class="btn btn-secondary mt-3">← Back to Dashboard</a>
</div>

</body>
</html>

<%@ page import="java.util.*,dao.*,model.*" %>

<%
List<Appointment> list =
new AppointmentDAO().getAll();
%>

<div class="container mt-4">

<h4>Appointments</h4>

<table class="table table-bordered">

<tr class="table-dark">
<th>User ID</th>
<th>Salon</th>
<th>Service</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Appointment a:list){ %>

<tr>

<td><%= a.getUserId() %></td>

<td>
<%
Salon salon = new SalonDAO().getSalonById(a.getSalonId());
out.print(salon.getName());
%>
</td>

<td><%= a.getServiceName() %></td>

<td><%= a.getAppointmentDate() %></td>
<td><%= a.getAppointmentTime() %></td>

<td><%= a.getStatus() %></td>

<td>
<a class="btn btn-success btn-sm"
href="AppointmentServlet?id=<%=a.getId()%>&st=Approved">
Approve</a>

<a class="btn btn-danger btn-sm"
href="AppointmentServlet?id=<%=a.getId()%>&st=Rejected">
Reject</a>
</td>

</tr>

<% } %>

</table>
</div>

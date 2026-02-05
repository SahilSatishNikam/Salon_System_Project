

<%@ page import="java.util.*,dao.*,model.*" %>

<%
List<Appointment> list=
new AppointmentDAO().getAll();
%>

<div class="container mt-4">

<h4>Appointments</h4>

<table class="table">

<tr class="table-dark">
<th>User</th>
<th>Service</th>
<th>Date</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Appointment a:list){ %>

<tr>

<td><%=a.getUser()%></td>
<td><%=a.getService()%></td>
<td><%=a.getDate()%></td>
<td><%=a.getStatus()%></td>

<td>
<a class="btn btn-success"
href="AppointmentServlet?id=<%=a.getId()%>&st=Approved">
Approve</a>

<a class="btn btn-danger"
href="AppointmentServlet?id=<%=a.getId()%>&st=Rejected">
Reject</a>
</td>

</tr>

<% } %>

</table>
</div>


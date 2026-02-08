<%@ page contentType="text/html;charset=UTF-8" %>
<%
model.Therapist t = (model.Therapist) session.getAttribute("therapist");
if(t == null){ response.sendRedirect("login.jsp"); return; }
%>

<h2>Set Availability</h2>
<form action="AddAvailabilityServlet" method="post">
<input type="hidden" name="therapistId" value="<%= t.getId() %>">

<label>Date:</label>
<input type="date" name="date" required><br><br>
<label>Start Time:</label>
<input type="time" name="start" required><br><br>
<label>End Time:</label>
<input type="time" name="end" required><br><br>
<label>Slot Duration (minutes):</label>
<input type="number" name="duration" value="30" required><br><br>

<button type="submit">Save Availability</button>
</form>

<br>
<a href="TherapistDashboardServlet">Back to Dashboard</a>

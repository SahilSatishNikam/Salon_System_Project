<%@ page import="model.Appointment,dao.AppointmentDAO" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
%>

<h2>Reschedule Appointment</h2>

<form action="RescheduleAppointmentServlet" method="post">
    <input type="hidden" name="id" value="<%=id%>">

    New Date:
    <input type="date" name="date" required><br><br>

    New Time:
    <input type="time" name="time" required><br><br>

    <button type="submit">Update</button>
</form>

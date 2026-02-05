<%@ page import="model.Appointment" %>
<%
    Appointment appt = (Appointment) request.getAttribute("appointment");
    if (appt == null) {
        response.sendRedirect("myAppointments.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reschedule Appointment</title>
</head>
<body>
    <h2>Reschedule Appointment</h2>
    <form action="RescheduleAppointmentServlet" method="post">
        <input type="hidden" name="id" value="<%= appt.getId() %>">
        <label>New Date:</label>
        <input type="date" name="appointmentDate" value="<%= appt.getAppointmentDate() %>" required><br><br>
        <label>New Time:</label>
        <input type="time" name="appointmentTime" value="<%= appt.getAppointmentTime() %>" required><br><br>
        <button type="submit">Update Appointment</button>
    </form>
</body>
</html>

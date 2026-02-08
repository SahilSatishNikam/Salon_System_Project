<%@ page import="java.util.*, java.time.LocalTime" %>
<%@ page import="model.TherapistAvailability" %>

<%
List<LocalTime> slots = (List<LocalTime>) request.getAttribute("slots");
int therapistId = (Integer) request.getAttribute("therapistId");
java.sql.Date date = (java.sql.Date) request.getAttribute("date");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Available Slots</title>
</head>
<body>

<h2>Available Slots</h2>

<%
if(slots == null || slots.isEmpty()) {
%>
<p>No slots available for this date</p>
<%
} else {
    for(LocalTime s : slots) {
%>
<form action="AppointmentServlet" method="post">
<input type="hidden" name="action" value="book">
<input type="hidden" name="therapistId" value="<%=therapistId%>">
<input type="hidden" name="date" value="<%=date%>">
<input type="hidden" name="time" value="<%=s%>">
<button type="submit">Book Slot <%=s%></button>
</form>
<br>
<%
    }
}
%>

<a href="therapistDashboard.jsp">Back</a>

</body>
</html>

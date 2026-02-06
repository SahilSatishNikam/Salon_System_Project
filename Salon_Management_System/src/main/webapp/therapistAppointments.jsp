<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Appointment" %>
<%
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
%>
<html>
<head>
    <title>Therapist Appointments</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h2>Appointments</h2>
<table border="1">
    <tr>
        <th>Service</th>
        <th>User ID</th>
        <th>Date</th>
        <th>Time</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    <c:forEach var="appt" items="${appointments}">
        <tr>
            <td>${appt.serviceName}</td>
            <td>${appt.userId}</td>
            <td>${appt.appointmentDate}</td>
            <td>${appt.appointmentTime}</td>
            <td>${appt.status}</td>
            <td>
                <form method="post" action="TherapistAppointmentServlet">
                    <input type="hidden" name="appointmentId" value="${appt.id}">
                    <c:choose>
                        <c:when test="${appt.status == 'Booked'}">
                            <input type="hidden" name="action" value="start">
                            <input type="submit" value="Start">
                        </c:when>
                        <c:when test="${appt.status == 'In Progress'}">
                            <input type="hidden" name="action" value="complete">
                            <input type="submit" value="Complete">
                        </c:when>
                        <c:otherwise>
                            <input type="submit" value="No Action" disabled>
                        </c:otherwise>
                    </c:choose>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
 
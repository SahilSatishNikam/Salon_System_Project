<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Appointment" %>
<%
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
%>
<html>
<head>
    <title>Admin Appointments</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h2>All Appointments</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Therapist ID</th>
        <th>Service</th>
        <th>Date</th>
        <th>Time</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    <c:forEach var="appt" items="${appointments}">
        <tr>
            <td>${appt.id}</td>
            <td>${appt.userId}</td>
            <td>${appt.therapistId}</td>
            <td>${appt.serviceName}</td>
            <td>${appt.appointmentDate}</td>
            <td>${appt.appointmentTime}</td>
            <td>${appt.status}</td>
            <td>
                <form method="post" action="AdminAppointmentServlet">
                    <input type="hidden" name="appointmentId" value="${appt.id}">
                    <select name="status">
                        <option value="Booked" ${appt.status=='Booked'?'selected':''}>Booked</option>
                        <option value="In Progress" ${appt.status=='In Progress'?'selected':''}>In Progress</option>
                        <option value="Completed" ${appt.status=='Completed'?'selected':''}>Completed</option>
                        <option value="Cancelled" ${appt.status=='Cancelled'?'selected':''}>Cancelled</option>
                    </select>
                    <input type="submit" value="Update">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

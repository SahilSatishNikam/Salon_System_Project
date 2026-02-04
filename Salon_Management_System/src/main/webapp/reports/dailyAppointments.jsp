<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="../DailyAppointmentReportServlet" method="get">
    Select Date:
    <input type="date" name="date" required>
    <button type="submit">View Report</button>
</form>

<hr>

<c:if test="${not empty report}">
<table border="1">
    <tr>
        <th>Appointment ID</th>
        <th>Therapist</th>
        <th>Status</th>
    </tr>

    <c:forEach var="r" items="${report}">
        <tr>
            <td>${r.appointmentId}</td>
            <td>${r.therapistName}</td>
            <td>${r.status}</td>
        </tr>
    </c:forEach>
</table>
</c:if>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
    <tr>
        <th>Therapist</th>
        <th>Total Appointments</th>
    </tr>

    <c:forEach var="t" items="${performance}">
        <tr>
            <td>${t.therapistName}</td>
            <td>${t.totalAppointments}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
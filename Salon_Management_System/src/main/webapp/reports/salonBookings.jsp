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
        <th>Salon</th>
        <th>Total Bookings</th>
    </tr>

    <c:forEach var="s" items="${salonReport}">
        <tr>
            <td>${s.salonName}</td>
            <td>${s.totalBookings}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
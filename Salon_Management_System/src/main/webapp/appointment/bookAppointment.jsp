<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="../BookAppointmentServlet" method="post">
    <input type="hidden" name="userId" value="1">
    <input type="hidden" name="therapistId" value="2">
    <input type="date" name="appointmentDate" required>
    <input type="submit" value="Next">
</form>

</body>
</html>
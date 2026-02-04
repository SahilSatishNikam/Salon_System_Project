<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="../TimeSlotServlet" method="post">
    <input type="hidden" name="therapistId" value="${therapistId}">
    <input type="hidden" name="date" value="${date}">
    <select name="timeSlot">
        <option>10:00-11:00</option>
        <option>11:00-12:00</option>
    </select>
    <input type="submit" value="Check">
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="../SubmitFeedbackServlet" method="post">

    <input type="hidden" name="userId" value="${sessionScope.userId}">
    <input type="hidden" name="salonId" value="1">
    <input type="hidden" name="therapistId" value="2">

    <label>Rate Salon:</label>
    <select name="salonRating" required>
        <option value="5">★★★★★</option>
        <option value="4">★★★★</option>
        <option value="3">★★★</option>
        <option value="2">★★</option>
        <option value="1">★</option>
    </select>

    <label>Rate Therapist:</label>
    <select name="therapistRating" required>
        <option value="5">★★★★★</option>
        <option value="4">★★★★</option>
        <option value="3">★★★</option>
        <option value="2">★★</option>
        <option value="1">★</option>
    </select>

    <label>Feedback:</label>
    <textarea name="comments" required></textarea>

    <button type="submit">Submit Feedback</button>
</form>

</body>
</html>
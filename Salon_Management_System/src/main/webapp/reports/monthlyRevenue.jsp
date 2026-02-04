<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="../MonthlyRevenueReportServlet" method="get">
    Select Month:
    <input type="month" name="month" required>
    <button type="submit">Generate</button>
</form>

<h3>Total Revenue: ₹ ${totalRevenue}</h3>

</body>
</html>
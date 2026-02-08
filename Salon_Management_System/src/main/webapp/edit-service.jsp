<%@ page import="model.Service" %>
<html>
<head><title>Edit Service</title></head>
<body>
<%
    Service s = (Service) request.getAttribute("service");
%>
<h2>Edit Service for Salon ID: <%= s.getSalonId() %></h2>
<form method="post" action="UpdateServiceServlet">
    <input type="hidden" name="id" value="<%= s.getId() %>">
    <input type="hidden" name="salonId" value="<%= s.getSalonId() %>">
    <input type="text" name="name" value="<%= s.getName() %>" placeholder="Service Name" required><br>
    <input type="text" name="description" value="<%= s.getDescription() %>" placeholder="Description"><br>
    <input type="number" name="price" value="<%= s.getPrice() %>" placeholder="Price" step="0.01" required><br>
    <input type="number" name="durationMinutes" value="<%= s.getDurationMinutes() %>" placeholder="Duration (min)" required><br>
    <button type="submit">Update Service</button>
</form>
</body>
</html>

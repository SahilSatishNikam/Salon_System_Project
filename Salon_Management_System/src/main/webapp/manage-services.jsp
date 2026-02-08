<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,model.*,dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Manage Services for <%= ((Salon)request.getAttribute("salon")).getName() %></h2>

<form method="post" action="AddServiceServlet">
    <input type="hidden" name="salonId" value="<%= ((Salon)request.getAttribute("salon")).getId() %>">
    <input type="text" name="name" placeholder="Service Name" required>
    <input type="text" name="description" placeholder="Description">
    <input type="number" name="price" placeholder="Price" required>
    <input type="number" name="durationMinutes" placeholder="Duration" required>
    <button>Add Service</button>
</form>

<table>
    <tr>
        <th>Name</th><th>Description</th><th>Price</th><th>Duration</th><th>Action</th>
    </tr>
    <%
        List<Service> services = (List<Service>) request.getAttribute("services");
        if(services != null && !services.isEmpty()) {
            for(Service s : services) {
    %>
        <tr>
            <td><%= s.getName() %></td>
            <td><%= s.getDescription() %></td>
            <td><%= s.getPrice() %></td>
            <td><%= s.getDurationMinutes() %></td>
            <td>
                <a href="EditServiceServlet?id=<%=s.getId()%>">Edit</a>
                <a href="DeleteServiceServlet?id=<%=s.getId()%>&salonId=<%= ((Salon)request.getAttribute("salon")).getId() %>">Delete</a>
            </td>
        </tr>
    <% } } else { %>
        <tr><td colspan="5">No services added yet</td></tr>
    <% } %>
</table>

</body>
</html>
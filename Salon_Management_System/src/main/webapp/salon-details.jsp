<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Salon Details</title>
    <link rel="stylesheet" href="../css/admin.css">
    <style>
        body { font-family: Arial; margin:20px; }
        .salon-info { display:flex; margin-bottom:20px; }
        .salon-info img { width:150px; height:150px; object-fit:cover; border-radius:5px; margin-right:20px; }
        .salon-info div { line-height:1.5; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        a.button { padding:6px 12px; background-color:blue; color:white; text-decoration:none; border-radius:4px; }
    </style>
</head>
<body>

<%
String salonIdParam = request.getParameter("salonId");
if(salonIdParam == null) {
    out.println("<p>No salon selected.</p>");
    return;
}

int salonId = Integer.parseInt(salonIdParam);
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();

Salon salon = salonDAO.getSalonById(salonId);
if(salon == null) {
    out.println("<p>Salon not found.</p>");
    return;
}

// Load services
List<Service> services = serviceDAO.getServicesBySalon(salonId);
%>

<h2>Salon Details</h2>
<div class="salon-info">
    <div>
        <% if(salon.getImage() != null) { %>
            <img src="SalonImageServlet?id=<%=salon.getId()%>" alt="<%=salon.getName()%>">
        <% } else { %>
            <img src="../images/no-image.png" alt="No Image">
        <% } %>
    </div>
    <div>
        <h3><%= salon.getName() %></h3>
        <p><strong>Email:</strong> <%= salon.getEmail() %></p>
        <p><strong>Phone:</strong> <%= salon.getPhone() %></p>
        <p><strong>Address:</strong> <%= salon.getAddress() %></p>
    </div>
</div>

<h3>Services Offered</h3>
<% if(services != null && !services.isEmpty()) { %>
<table>
    <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Duration</th>
        <th>Action</th>
    </tr>
    <% for(Service s : services) { %>
    <tr>
        <td><%= s.getName() %></td>
        <td><%= s.getDescription() != null ? s.getDescription() : "" %></td>
        <td>$<%= s.getPrice() %></td>
        <td><%= s.getDurationMinutes() %> min</td>
        <td>
            <a class="button" href="book-appointment.jsp?salonId=<%=salon.getId()%>&serviceId=<%=s.getId()%>">Book Now</a>
        </td>
    </tr>
    <% } %>
</table>
<% } else { %>
<p>No services available for this salon yet.</p>
<% } %>

</body>
</html>



<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Salons</title>
    <link rel="stylesheet" href="../css/admin.css">
    <style>
        body { font-family: Arial; margin:20px; }
        .search-bar { margin-bottom: 20px; }
        .search-bar input, .search-bar button { padding: 8px; margin-right: 5px; }
        .salon-card { border:1px solid #ccc; border-radius:5px; padding:15px; margin-bottom:15px; display:flex; align-items:center; }
        .salon-card img { border-radius:5px; margin-right:15px; width:120px; height:120px; object-fit:cover; }
        .salon-card h3 { margin:0; }
        .salon-card p { margin:5px 0; }
        .salon-card a { margin-right:10px; text-decoration:none; color:blue; }
    </style>
</head>
<body>

<h2>Search Salons</h2>

<!-- Search Form -->
<div class="search-bar">
    <form method="get" action="search-salons.jsp">
        <input type="text" name="name" placeholder="Salon Name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
        <input type="text" name="location" placeholder="Location" value="<%= request.getParameter("location") != null ? request.getParameter("location") : "" %>">
        <button type="submit">Search</button>
    </form>
</div>

<%
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();

// Get search parameters
String name = request.getParameter("name");
String location = request.getParameter("location");

// Determine if user searched
boolean searched = (name != null && !name.trim().isEmpty()) || (location != null && !location.trim().isEmpty());

// Fetch salons based on search
List<Salon> salons = new ArrayList<>();
try {
    if(searched) {
        salons = salonDAO.searchSalons(name, location, null);
    } else {
        salons = salonDAO.getAllSalons();
    }

    // Load services for each salon (optional, for details)
    for(Salon s : salons) {
        s.setServices(serviceDAO.getServicesBySalon(s.getId()));
    }
} catch(Exception e){
    out.println("<p style='color:red;'>Error fetching salons: " + e.getMessage() + "</p>");
}
%>

<!-- Display Search Results -->
<div>
<% if(salons != null && !salons.isEmpty()) {
    for(Salon s : salons) { %>
    <div class="salon-card">
        <div>
            <% if(s.getImage() != null) { %>
                <img src="SalonImageServlet?id=<%=s.getId()%>" alt="<%=s.getName()%>">
            <% } else { %>
                <img src="../images/no-image.png" alt="No Image">
            <% } %>
        </div>
        <div>
            <h3><%= s.getName() %></h3>
            <p><strong>Location:</strong> <%= s.getAddress() %></p>
            <p><strong>Email:</strong> <%= s.getEmail() %> | <strong>Phone:</strong> <%= s.getPhone() %></p>
            <!-- FIXED: use servlet for Book Now -->
            <a href="<%= request.getContextPath() %>/book-appointment?salonId=<%= s.getId() %>">Book Now</a>
            
            <a href="salon-details.jsp?salonId=<%=s.getId()%>">Explore Details</a>
        </div>
    </div>
<% } } else { %>
<p>No salons found.</p>
<% } %>
</div>

</body>
</html>
<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<html>
<head>
<title>Manage Salons & Services</title>
<link rel="stylesheet" href="../css/admin.css">
<style>
body { font-family: Arial; margin:20px; }
table { border-collapse: collapse; width: 100%; margin-top: 20px; }
th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
th { background-color: #f2f2f2; }
form input, form button { padding: 6px; margin: 3px 0; }
img { border-radius: 5px; }
.service-table { margin-left: 30px; border: 1px solid #aaa; width: 90%; }
.service-table th, .service-table td { border: 1px solid #aaa; padding: 5px; }
</style>
<script>
function toggleServiceForm(id) {
    const form = document.getElementById('serviceForm-' + id);
    form.style.display = form.style.display === 'none' ? 'block' : 'none';
}
</script>
</head>
<body>
<h2>Add New Salon</h2>
<form method="post" action="AddSalonServlet" enctype="multipart/form-data">
    <input type="text" name="name" placeholder="Salon Name" required>
    <input type="text" name="email" placeholder="Email">
    <input type="text" name="phone" placeholder="Phone">
    <input type="text" name="address" placeholder="Address">
    <input type="file" name="image" required>
    <button type="submit">Add Salon</button>
</form>

<h2>All Salons</h2>
<%
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();
List<Salon> salons = salonDAO.getAllSalons();

for(Salon s : salons) {
    s.setServices(serviceDAO.getServicesBySalon(s.getId())); // load services for each salon
%>
<table>
<tr>
<td rowspan="2" style="width:100px;">
<% if(s.getImage() != null) { %>
<img src="SalonImageServlet?id=<%=s.getId()%>" width="80" height="80">
<% } else { %>No Image<% } %>
</td>
<td>Name: <%= s.getName() %></td>
<td>Email: <%= s.getEmail() %></td>
<td>Phone: <%= s.getPhone() %></td>
<td>Address: <%= s.getAddress() %></td>
<td>
<a href="EditSalonServlet?id=<%=s.getId()%>">Edit</a> | 
<a href="DeleteSalonServlet?id=<%=s.getId()%>" onclick="return confirm('Delete this salon?')">Delete</a> | 
<a href="javascript:void(0)" onclick="toggleServiceForm(<%=s.getId()%>)">Manage Services</a>
</td>
</tr>

<tr>
<td colspan="5">
<div id="serviceForm-<%=s.getId()%>" style="display:none; margin-top:10px;">
<h4>Services for <%= s.getName() %></h4>

<!-- Add Service Form -->
<form method="post" action="AddServiceServlet">
    <input type="hidden" name="salonId" value="<%= s.getId() %>">
    <input type="text" name="name" placeholder="Service Name" required>
    <input type="text" name="description" placeholder="Description">
    <input type="number" name="price" placeholder="Price" required step="0.01">
    <input type="number" name="durationMinutes" placeholder="Duration (min)" required>
    <button type="submit">Add Service</button>
</form>

<!-- List Existing Services -->
<table class="service-table">
<tr><th>Name</th><th>Description</th><th>Price</th><th>Duration</th><th>Actions</th></tr>
<% if(s.getServices() != null && !s.getServices().isEmpty()) {
    for(Service srv : s.getServices()) { %>
<tr>
<td><%= srv.getName() %></td>
<td><%= srv.getDescription() %></td>
<td>$<%= srv.getPrice() %></td>
<td><%= srv.getDurationMinutes() %> min</td>
<td>
<a href="EditServiceServlet?id=<%= srv.getId() %>">Edit</a> | 
<a href="DeleteServiceServlet?id=<%= srv.getId() %>&salonId=<%= s.getId() %>" onclick="return confirm('Delete this service?')">Delete</a>
</td>
</tr>
<% } } else { %>
<tr><td colspan="5">No services yet.</td></tr>
<% } %>
</table>

</div>
</td>
</tr>
</table>
<% } %>

</body>
</html>

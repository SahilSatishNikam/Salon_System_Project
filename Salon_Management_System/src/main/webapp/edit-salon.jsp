

<%@ page import="dao.SalonDAO, model.Salon" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
Salon salon = new SalonDAO().getSalonById(id);
%>
<html>
<head>
<title>Edit Salon</title>
<link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h2>Edit Salon</h2>
<form method="post" action="editSalon" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= salon.getId() %>">
    <input name="name" placeholder="Salon Name" value="<%= salon.getName() %>" required>
    <input name="email" placeholder="Email" value="<%= salon.getEmail() %>">
    <input name="phone" placeholder="Phone" value="<%= salon.getPhone() %>">
    <input name="address" placeholder="Address" value="<%= salon.getAddress() %>">
    <p>Current Image:</p>
    <img src="salon-image?id=<%= salon.getId() %>" width="100">
    <p>Change Image:</p>
    <input type="file" name="image">
    <button type="submit">Update Salon</button>
</form>
</body>
</html>
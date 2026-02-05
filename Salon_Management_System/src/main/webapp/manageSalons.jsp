
<%@ page import="java.util.*,dao.*,model.*" %>

<%
SalonDAO dao = new SalonDAO();

List<Salon> list;

if(session.getAttribute("search")!=null)
 list=(List<Salon>)session.getAttribute("search");
else
 list=dao.getAll();
%>

<!DOCTYPE html>
<html>
<head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<div class="container mt-4">

<div class="card p-4 shadow">

<h4>Manage Salons</h4>

<form action="ManageSalonServlet" method="post"
enctype="multipart/form-data">

<input name="name" class="form-control mb-2"
placeholder="Salon Name" required>

<input name="owner" class="form-control mb-2"
placeholder="Owner Name" required>

<textarea name="desc"
class="form-control mb-2"></textarea>

<input type="file" name="file"
class="form-control mb-2">

<button class="btn btn-primary">
Add Salon
</button>

</form>

<hr>

<form action="ManageSalonServlet" method="get">

<input name="key"
class="form-control w-50 mb-3"
placeholder="Search salon">

</form>

<table class="table">

<tr class="table-dark">
<th>Name</th>
<th>Owner</th>
<th>Description</th>
<th>Image</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Salon s:list){ %>

<tr>

<td><%=s.getSalon_name()%></td>

<td><%=s.getOwner_name()%></td>

<td><%=s.getDescription()%></td>

<td><%=s.getImage_name()%></td>

<td><%=s.getStatus()%></td>

<td>
<a class="btn btn-danger"
href="ManageSalonServlet?action=delete&id=<%=s.getId()%>">
Delete
</a>
</td>

</tr>

<% } %>

</table>

</div>
</div>

</body>
</html>



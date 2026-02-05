<%@ page import="java.util.*,dao.*,model.*" %>

<%
SalonDAO dao = new SalonDAO();
List<Salon> list = dao.getAll();
%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Salon Owners</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-4">

<div class="card p-4 shadow">

<h4>Manage Salon Owners</h4>

<table class="table table-bordered">

<tr class="table-dark">
<th>ID</th>
<th>Salon Name</th>
<th>Owner</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Salon o : list){ %>

<tr>

<td><%=o.getId()%></td>

<td><%=o.getSalon_name()%></td>

<td><%=o.getOwner_name()%></td>

<td>

<% if("Approved".equals(o.getStatus())){ %>

Approved

<% } else if("Rejected".equals(o.getStatus())){ %>

Rejected

<% } else { %>

Pending

<% } %>

</td>

<td>
<a class="btn btn-danger"
href="OwnerServlet?action=delete&id=<%=o.getId()%>">
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


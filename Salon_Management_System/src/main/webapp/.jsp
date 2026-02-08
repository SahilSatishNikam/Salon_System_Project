<%@ page import="java.util.*, dao.*, model.*" %>
<%
AdminDAO dao = new AdminDAO();
List<Admin> list = dao.getAllOwners();

String msg = (String) session.getAttribute("msg");
session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage & Verify Owners</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body { background: #eef2f7; }
.card { border-radius: 15px; }
</style>
</head>
<body>

<div class="container mt-4">
<div class="card p-4 shadow">

<h3 class="text-primary"><i class="fa fa-users"></i> Manage & Verify Owners</h3>

<!-- Message -->
<% if(msg != null){ %>
<div class="alert alert-success"><%= msg %></div>
<% } %>

<!-- Summary Counts -->
<div class="row mb-3">
<div class="col-md-4">
<div class="alert alert-warning">
Pending: <%= list.stream().filter(o -> "Pending".equals(o.getStatus())).count() %>
</div>
</div>
<div class="col-md-4">
<div class="alert alert-success">
Approved: <%= list.stream().filter(o -> "Approved".equals(o.getStatus())).count() %>
</div>
</div>
<div class="col-md-4">
<div class="alert alert-danger">
Rejected: <%= list.stream().filter(o -> "Rejected".equals(o.getStatus())).count() %>
</div>
</div>
</div>

<!-- Table -->
<table class="table table-bordered table-hover">
<tr class="table-dark">
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Admin o : list){ %>
<tr>
<td><%= o.getId() %></td>
<td><%= o.getName() %></td>
<td><%= o.getEmail() %></td>
<td><%= o.getPhone() %></td>

<td>
<% if("Approved".equals(o.getStatus())){ %>
<span class="badge bg-success">Approved</span>
<% } else if("Rejected".equals(o.getStatus())){ %>
<span class="badge bg-danger">Rejected</span>
<% } else { %>
<span class="badge bg-warning text-dark">Pending</span>
<% } %>
</td>

<td>
<!-- Approve / Reject / Delete buttons -->
<a class="btn btn-success btn-sm"
   href="AdminServlet?action=approve&id=<%=o.getId()%>"
   onclick="return confirm('Approve this owner?')">
<i class="fa fa-check"></i> Approve</a>

<a class="btn btn-danger btn-sm"
   href="AdminServlet?action=reject&id=<%=o.getId()%>"
   onclick="return confirm('Reject this owner?')">
<i class="fa fa-times"></i> Reject</a>

<a class="btn btn-dark btn-sm"
   href="AdminServlet?action=delete&id=<%=o.getId()%>"
   onclick="return confirm('Delete this owner?')">
<i class="fa fa-trash"></i> Delete</a>
</td>
</tr>
<% } %>

</table>

</div>
</div>

</body>
</html>

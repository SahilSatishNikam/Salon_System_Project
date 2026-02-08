<%@ page import="java.util.*,dao.*,model.*" %>

<%
SalonDAO dao = new SalonDAO();
List<Salon> list = new ArrayList<>();

try{
    list = dao.getAllSalons();
}catch(Exception e){
    e.printStackTrace();
}

String msg = (String)session.getAttribute("msg");
session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Verify Salons</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{ background:#eef2f7; }
.card{ border-radius:15px; }
</style>

</head>
<body>

<div class="container mt-4">
<div class="card p-4 shadow">

<h3 class="text-primary"><i class="fa fa-check-circle"></i> Verify Salons</h3>

<% if(msg!=null){ %>
<div class="alert alert-success"><%=msg%></div>
<% } %>

<!-- Summary -->
<div class="row mb-3">
<div class="col-md-4">
<div class="alert alert-warning">
Pending: <%= list.stream().filter(s->"Pending".equals(s.getStatus())).count() %>
</div>
</div>
<div class="col-md-4">
<div class="alert alert-success">
Approved: <%= list.stream().filter(s->"Approved".equals(s.getStatus())).count() %>
</div>
</div>
<div class="col-md-4">
<div class="alert alert-danger">
Rejected: <%= list.stream().filter(s->"Rejected".equals(s.getStatus())).count() %>
</div>
</div>
</div>

<!-- Table -->
<table class="table table-bordered">
<tr class="table-dark">
<th>ID</th>
<th>Salon Name</th>
<th>Address</th>
<th>Status</th>
<th>Action</th>
</tr>

<% for(Salon s:list){ %>
<tr>
<td><%=s.getId()%></td>
<td><%=s.getName()%></td>
<td><%=s.getAddress()%></td>

<td>
<% if("Approved".equals(s.getStatus())){ %>
<span class="badge bg-success">Approved</span>
<% } else if("Rejected".equals(s.getStatus())){ %>
<span class="badge bg-danger">Rejected</span>
<% } else { %>
<span class="badge bg-warning text-dark">Pending</span>
<% } %>
</td>

<td>
<a class="btn btn-success btn-sm"
   onclick="return confirm('Approve this salon?')"
   href="OwnerServlet?action=approve&id=<%=s.getId()%>">
<i class="fa fa-check"></i> Approve</a>

<a class="btn btn-danger btn-sm"
   onclick="return confirm('Reject this salon?')"
   href="OwnerServlet?action=reject&id=<%=s.getId()%>">
<i class="fa fa-times"></i> Reject</a>

<a class="btn btn-dark btn-sm"
   onclick="return confirm('Delete this salon?')"
   href="OwnerServlet?action=delete&id=<%=s.getId()%>">
<i class="fa fa-trash"></i> Delete</a>
</td>
</tr>
<% } %>

</table>
</div>
</div>

</body>
</html>

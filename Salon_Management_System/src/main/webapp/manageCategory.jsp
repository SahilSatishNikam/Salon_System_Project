<%@ page import="java.util.*,dao.*,model.*" %>

<%
List<Category> list=new CategoryDAO().getAll();
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">
<div class="card p-3 shadow">

<h4 class="text-primary">Manage Categories</h4>

<form action="CategoryServlet" method="post">

<input name="name" class="form-control w-50"
placeholder="Category Name">

<button class="btn btn-success mt-2">
Add Category
</button>

</form>

<table class="table mt-3">
<tr class="table-dark">
<th>ID</th>
<th>Name</th>
<th>Action</th>
</tr>

<% for(Category c:list){ %>

<tr>
<td><%=c.getId()%></td>
<td><%=c.getName()%></td>

<td>
<a class="btn btn-danger"
href="CategoryServlet?id=<%=c.getId()%>">
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



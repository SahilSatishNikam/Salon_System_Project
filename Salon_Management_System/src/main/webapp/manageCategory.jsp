<%@ page import="java.util.*,dao.*,model.*" %>

<%
    List<Category> list = new CategoryDAO().getAll();
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Categories</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome Icons -->
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    background:#000;
    font-family:Arial, sans-serif;
}

/* Card */
.card{
    background:#111;
    border:1px solid #d4af37;
    border-radius:16px;
    box-shadow:0 0 25px rgba(212,175,55,.4);
}

/* Heading */
.page-title{
    color:#ffd700;
    font-weight:600;
    display:flex;
    align-items:center;
    gap:10px;
}

/* Icon */
.icon-gold{
    color:#ffd700;
    font-size:26px;
}

/* Input */
.form-control{
    background:#000;
    color:#fff;
    border:1px solid #d4af37;
    border-radius:25px;
}
.form-control::placeholder{
    color:#aaa;
}
.form-control:focus{
    background:#000;
    color:#fff;
    border-color:#ffd700;
    box-shadow:0 0 10px rgba(255,215,0,.8);
}

/* Add Button */
.btn-gold{
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
    border:none;
    font-weight:600;
    border-radius:25px;
    padding:6px 22px;
}
.btn-gold:hover{
    box-shadow:0 0 15px rgba(255,215,0,1);
}

/* Table */
.table{
    color:#fff;
}
.table thead th{
    color:#ffd700;
    border-bottom:2px solid #d4af37;
}
.table tbody tr{
    background:#111;
}
.table tbody tr:hover{
    background:#1c1c1c;
}

/* Delete Button */
.btn-danger{
    background:#000;
    border:1px solid #ff4d4d;
    color:#ff4d4d;
    border-radius:20px;
}
.btn-danger:hover{
    background:#ff4d4d;
    color:#000;
}
</style>
</head>

<body>

<div class="container mt-5">
<div class="card p-4">

<!-- Heading with Icon -->
<h4 class="page-title mb-3">
    <i class="fa-solid fa-layer-group icon-gold"></i>
    Manage Categories
</h4>

<!-- Add Category -->
<form action="CategoryServlet" method="post" class="mb-4">

<input name="name" class="form-control w-50"
       placeholder="Category Name" required>

<button class="btn btn-gold mt-3">
    <i class="fa fa-plus"></i> Add Category
</button>

</form>

<!-- Table -->
<table class="table mt-3">
<thead>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<% for(Category c:list){ %>
<tr>
    <td><%=c.getId()%></td>
    <td><%=c.getName()%></td>
    <td>
        <a class="btn btn-danger"
           href="CategoryServlet?id=<%=c.getId()%>"
           onclick="return confirm('Are you sure you want to delete?')">
           <i class="fa fa-trash"></i> Delete
        </a>
    </td>
</tr>
<% } %>
</tbody>

</table>

</div>
</div>

</body>
</html>

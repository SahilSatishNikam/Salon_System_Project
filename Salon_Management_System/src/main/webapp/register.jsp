<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Register</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background:#f4f6f9;
        }
        .card{
            border-radius:15px;
        }
    </style>
</head>

<body>

<div class="container mt-5" style="max-width:500px;">
    <div class="card shadow p-4">

        <h3 class="text-center mb-3">User Registration</h3>

        <% if(request.getParameter("msg")!=null){ %>
            <div class="alert alert-info">
                <%=request.getParameter("msg")%>
            </div>
        <% } %>

     <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">


<div class="mb-3">
<label>Name</label>
<input type="text" name="name" class="form-control" required>
</div>

<div class="mb-3">
<label>Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="mb-3">
<label>Password</label>
<input type="password" name="password" class="form-control" required>
</div>

<div class="mb-3">
<label>Phone</label>
<input type="text" name="phone" class="form-control">
</div>

<!-- ROLE DROPDOWN -->
<div class="mb-3">
<label>Select Role</label>
<select name="role" class="form-control" required>
<option value="">--Select Role--</option>
<option value="admin">Admin</option>
<option value="user">User</option>
<option value="therapist">Therapist</option>
</select>
</div>

<button type="submit" class="btn btn-success w-100">Register</button>
</form>


        <div class="text-center mt-3">
            Already registered?
            <a href="login.jsp">Login</a>
        </div>

    </div>
</div>

</body>
</html>

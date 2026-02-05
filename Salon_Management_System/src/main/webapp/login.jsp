

<!DOCTYPE html>
<html>
<head>

<title>Admin Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
 background: linear-gradient(to right,#0f2027,#203a43,#2c5364);
}
.card{
 border-radius:15px;
}
</style>

</head>

<body>

<div class="container mt-5">
<div class="row justify-content-center">

<div class="col-md-4">
<div class="card p-4 shadow">

<h3 class="text-center text-primary">
<i class="fa fa-user-shield"></i> Admin Login
</h3>

<form action="AdminLoginServlet" method="post">

<input type="hidden" name="action" value="login">

<div class="mb-3">
<label>Email</label>
<input name="email" class="form-control"
placeholder="Enter email">
</div>

<div class="mb-3">
<label>Password</label>
<input name="password" type="password"
class="form-control"
placeholder="Enter password">
</div>

<button class="btn btn-primary w-100">
Login
</button>

</form>

<div class="text-center mt-3">
New Admin?
<a href="register.jsp">Register Here</a>
</div>

</div>
</div>

</div>
</div>

</body>
</html>



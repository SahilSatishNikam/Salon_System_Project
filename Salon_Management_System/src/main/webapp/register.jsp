<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: #f5f5f5; }
.card { max-width: 450px; margin: 60px auto; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
</style>
</head>
<body>
<div class="card">
  <div class="card-body">
    <h3 class="card-title text-center mb-4">Register</h3>
    <% if(request.getParameter("error") != null){ %>
      <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>
    <form action="RegisterServlet" method="post">
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
      <button type="submit" class="btn btn-success w-100">Register</button>
    </form>
    <p class="mt-3 text-center">Already have an account? <a href="login.jsp">Login</a></p>
  </div>
</div>
</body>
</html>
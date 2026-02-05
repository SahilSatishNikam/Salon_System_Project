<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: #f5f5f5; }
.card { max-width: 400px; margin: 80px auto; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
</style>
</head>
<body>
<div class="card">
  <div class="card-body">
    <h3 class="card-title text-center mb-4">Login</h3>
    <% if(request.getParameter("error") != null){ %>
      <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>
    <% if(request.getParameter("success") != null){ %>
      <div class="alert alert-success"><%= request.getParameter("success") %></div>
    <% } %>
    <form action="LoginServlet" method="post">
      <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control" required autocomplete="off">
      </div>
      <div class="mb-3">
        <label>Password</label>
       <input type="password" name="password" class="form-control" required autocomplete="new-password">
      </div>
      <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
    <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register</a></p>
  </div>
</div>
</body>
</html>
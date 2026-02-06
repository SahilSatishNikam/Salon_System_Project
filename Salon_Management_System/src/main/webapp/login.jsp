<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{background:#f4f6f9;}
        .card{max-width:420px;margin:80px auto;border-radius:15px;}
    </style>
</head>

<body>

<div class="card shadow p-4">
    <h3 class="text-center mb-3">Login</h3>

    <% if(request.getParameter("error")!=null){ %>
        <div class="alert alert-danger">
            <%=request.getParameter("error")%>
        </div>
    <% } %>

    <form action="LoginServlet" method="post">

        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button class="btn btn-primary w-100">Login</button>
    </form>

</div>

</body>
</html>

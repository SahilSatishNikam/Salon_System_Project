<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Luxury Salon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <div class="card shadow-lg p-4">
                <h3 class="text-center mb-4">Login</h3>

                <% if(request.getParameter("success") != null){ %>
                    <div class="alert alert-success text-center">
                        <%= request.getParameter("success") %>
                    </div>
                <% } %>

                <% if(request.getParameter("error") != null){ %>
                    <div class="alert alert-danger text-center">
                        <%= request.getParameter("error") %>
                    </div>
                <% } %>

                <form action="<%=request.getContextPath()%>/LoginServlet" method="post">

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Enter email" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Login As</label>
                        <select name="role" class="form-select" required>
                            <option value="">-- Select Role --</option>
                            <option value="USER">User</option>
                            <option value="ADMIN">Admin</option>
                            <option value="THERAPIST">Therapist</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>

            </div>

        </div>
    </div>
</div>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Luxury Salon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{
            background: linear-gradient(135deg, #f857a6, #ff5858);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .card{
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        h3{
            text-align: center;
            color: #198754;
            margin-bottom: 20px;
        }
        .custom-input{
            height: 45px;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .custom-btn{
            height: 45px;
            border-radius: 10px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="card">
    <h3>Register</h3>

    <% if(request.getParameter("error") != null){ %>
        <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/RegisterServlet" method="post">
        <input type="text" name="name" class="form-control custom-input" placeholder="Full Name" required>
        <input type="email" name="email" class="form-control custom-input" placeholder="Email (if USER or THERAPIST)">
        <input type="password" name="password" class="form-control custom-input" placeholder="Password" required>
        <input type="text" name="phone" class="form-control custom-input" placeholder="Phone (USER or THERAPIST)">
        <input type="text" name="specialization" class="form-control custom-input" placeholder="Specialization (THERAPIST)">

        <select name="role" class="form-control custom-input" required>
            <option value="">Select Role</option>
            <option value="USER">Customer</option>
            <option value="ADMIN">Admin</option>
            <option value="THERAPIST">Therapist</option>
        </select>

        <button class="btn btn-success w-100 custom-btn">Register</button>
    </form>

    <p class="mt-3 text-center">
        Already have an account? <a href="login.jsp">Login</a>
    </p>
</div>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Luxury Salon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body{
            background: linear-gradient(135deg, #1f2933, #111827);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
        }
        .card{
            background: #343a40;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 12px 30px rgba(0,0,0,0.5);
        }
        .btn-custom{
            margin-top: 15px;
            width: 100%;
            height: 45px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Welcome to Luxury Salon</h2>
    <p>Choose an action</p>
    <a href="register.jsp" class="btn btn-success btn-custom">Register</a>
    <a href="login.jsp" class="btn btn-primary btn-custom">Login</a>
</div>
</body>
</html>


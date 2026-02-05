<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Therapist Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #000000, #111111);
            color: gold;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 40px;
            background: #111;
            border: 2px solid gold;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(255,215,0,0.4);
        }

        .login-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 0 0 10px gold;
        }

        .input-group-text {
            background: #222;
            color: gold;
            border: 1px solid gold;
        }

        .form-control {
            background: #222;
            color: gold;
            border: 1px solid gold;
        }

        .form-control:focus {
            background: #222;
            color: gold;
            border-color: gold;
            box-shadow: 0 0 8px gold;
        }

        /* ================= GOLDEN BUTTON (NO BLUE ANYWHERE) ================= */

        .btn-primary{
            background: #FFD700;       /* GOLD */
            color: black;
            width: 100%;
            padding: 14px;
            font-size: 18px;
            border-radius: 50px;
            font-weight: bold;
            border: none;
            box-shadow: 0 5px 15px rgba(255,215,0,0.4);
            transition: all 0.3s ease;
        }

        .btn-primary:hover{
            background: #ffcc00;       /* darker gold */
            color: black;
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(255,215,0,0.7);
        }

        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary:focus:active{
            background: #FFD700;
            color: black;
            box-shadow: 0 0 15px rgba(255,215,0,0.8);
            outline: none;
        }

        .text-danger {
            margin-top: 15px;
            text-align: center;
            text-shadow: 0 0 5px red;
        }
    </style>
</head>

<body>

<div class="login-container">
    <div class="login-title">Therapist Login</div>

    <form action="TherapistLoginServlet" method="post">

        <div class="mb-3 input-group">
            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
            <input type="email" class="form-control" name="email" required>
        </div>

        <div class="mb-3 input-group">
            <span class="input-group-text"><i class="fas fa-lock"></i></span>
            <input type="password" class="form-control" name="password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
    </form>

    <% if(request.getAttribute("error") != null){ %>
        <p class="text-danger"><%= request.getAttribute("error") %></p>
    <% } %>
</div>

</body>
</html>

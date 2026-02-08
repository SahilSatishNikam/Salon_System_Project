<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | GoldenGlow</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
    min-height:100vh;
    margin:0;
    background:
        linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
        url('https://i.pinimg.com/originals/c2/89/3e/c2893e9a4eb9d576c6f6f21c4e95e95a.jpg');
    background-size:cover;
    background-position:center;
    font-family: "Times New Roman", Times, serif;
    font-size:17px;   /* 👈 added */
    color:#e5c66d;
}



        /* ===== NAVBAR ===== */
        .navbar{
            padding:18px 60px;
            background:rgba(0,0,0,0.65);
            backdrop-filter: blur(6px);
        }
        .navbar-brand{
            font-size:24px;
            font-weight:600;
            color:#e5c66d;
            letter-spacing:1px;
        }
        .navbar-brand span{
            color:#f0d14a;
        }
        .nav-link{
            color:#d6c17c !important;
            margin:0 10px;
        }
        .nav-link:hover{
            color:#f0d14a !important;
        }

        .login-btn,.register-btn{
            padding:8px 18px;
            border-radius:20px;
            text-decoration:none;
            margin-left:10px;
            font-weight:500;
            color:#000
        }
        .login-btn{
            border:1px solid #e5c66d;
            color:#e5c66d;
        }
        .register-btn{
            background:linear-gradient(135deg,#f0d14a,#c9a227);
            box-shadow:0 0 15px rgba(229,198,109,0.7);
        }

        /* ===== LOGIN CARD ===== */
        .card{
            max-width:420px;
            margin:90px auto;
            background:rgba(20,20,20,0.85);
            border-radius:18px;
            padding:35px;
            box-shadow:0 0 25px rgba(229,198,109,0.25);
            border:1px solid rgba(229,198,109,0.25);
        }

       .card h3{
    text-align:center;
    color:#f0d14a;
    font-weight:600;
    margin-bottom:25px;
    font-size:26px;   /* 👈 increased */
}


       label{
    color:#d6c17c;
    font-size:16px;   /* 👈 increased */
    margin-bottom:6px;
}

.form-control{
    background:#111;
    border:1px solid #333;
    color:#f5e6b0;
    border-radius:12px;
    padding:14px;     /* 👈 more space */
    font-size:16px;   /* 👈 increased */
}

        .form-control::placeholder{
            color:#888;
        }
        .form-control:focus{
            background:#111;
            color:#fff;
            border-color:#e5c66d;
            box-shadow:0 0 10px rgba(229,198,109,0.5);
        }

        /* ===== BUTTON ===== */
        .btn-primary{
    background:linear-gradient(135deg,#f0d14a,#c9a227);
    border:none;
    color:#000;
    font-weight:600;
    padding:14px;
    border-radius:25px;
    letter-spacing:1px;
    font-size:17px;   /* 👈 increased */
    transition:0.3s;
}

        .btn-primary:hover{
            background:linear-gradient(135deg,#ffd84d,#e5c66d);
            box-shadow:0 0 15px rgba(229,198,109,0.7);
        }

        /* ===== FOOTER ===== */
        .footer{
    background:#000;
    color:#aaa;
    text-align:center;
    padding:10px;
    border-top:1px solid rgba(201,162,39,.3);
    font-size:13px;
}
    </style>
</head>

<body>

<nav class="navbar d-flex justify-content-between">
    <div class="navbar-brand">
        <span>GoldenGlow</span>
    </div>

    <div>
        <a class="nav-link d-inline" href="index.jsp">Home</a>
        <a class="nav-link d-inline" href="about.jsp">About</a>
        <a class="nav-link d-inline" href="contact.jsp">Contact</a>

        <a href="login.jsp" class="login-btn">Login</a>
        <a href="register.jsp" class="register-btn">Register</a>
    </div>
</nav>

<div class="card">
    <h3>Login Page</h3>

    <% if(request.getParameter("error")!=null){ %>
        <div class="alert alert-danger">
            <%=request.getParameter("error")%>
        </div>
    <% } %>

    <form action="LoginServlet" method="post">

        <div class="mb-3">
            <label>Email Address</label>
            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>

        <button class="btn btn-primary w-100 mt-2">Login</button>
    </form>
</div>

<div class="footer">
© 2026 GoldenGlow Salon | All Rights Reserved
</div>

</body>
</html>

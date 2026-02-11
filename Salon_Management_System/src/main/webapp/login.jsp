<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | GoldenGlow</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
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
    overflow: hidden; 
    animation: fadeInPage 1s ease-in-out;
}
@keyframes fadeInPage {
    from {
        opacity: 0;
        transform: scale(1.01);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}
.card:hover {
    box-shadow: 0 0 40px rgba(229,198,109,0.45);
    transform: translateY(-4px);
    transition: all 0.4s ease;
}


        /* ===== LOGIN CARD ===== */
        .card{
            max-width:420px;
            margin:90px auto;
            background:rgba(20,20,20,0.85);
            border-radius:18px;
            padding:50px;
            box-shadow:0 0 25px rgba(229,198,109,0.25);
            border:1px solid rgba(229,198,109,0.25);
            animation: slideUp 0.9s ease-out;
        }
        @keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(40px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
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
     transition: all 0.3s ease;
}
.form-control:hover {
    border-color: rgba(229,198,109,0.6);
    box-shadow: 0 0 8px rgba(229,198,109,0.25);
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
    position: relative;
    overflow: hidden;
}
.btn-primary::after {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(255,255,255,0.4),
        transparent
    );
    transition: 0.5s;
}

.btn-primary:hover::after {
    left: 100%;
}

.btn-primary:active {
    transform: scale(0.96);
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
.nav-link {
    position: relative;
}

.nav-link::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -4px;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, #f0d14a, #c9a227);
    transition: width 0.3s ease;
}

.nav-link:hover::after {
    width: 100%;
}

    </style>
</head>

<body>

<!-- HEADER -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top shadow-lg glass-nav">
    <div class="container">

        <a class="navbar-brand fw-bold gold brand-glow brand-premium"
           href="${pageContext.request.contextPath}/index.jsp">

            <span class="brand-icon gold-icon">
                <!-- ICON UNCHANGED -->
                <svg class="scissor-lg" viewBox="0 0 24 24"
                     xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                    <path d="M9 12l-5 5a3 3 0 1 1-1.4-1.4l5-5-5-5A3 3 0 1 1 4 4l5 5 6-3-3 6 3 6-6-3z"
                          fill="#FFD700"/>
                </svg>
            </span>

            <span class="brand-text">
                Golden<span class="brand-accent">Glow</span>
            </span>
        </a>

        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto gap-3 align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link nav-underline"
                       href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-underline"
                       href="${pageContext.request.contextPath}/about.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-underline"
                       href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3 glow-hover"
                       href="${pageContext.request.contextPath}/login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-gold btn-sm rounded-pill px-3 glow-btn"
                       href="${pageContext.request.contextPath}/register.jsp">Register</a>
                </li>
            </ul>
        </div>
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

<div class="footer-bottom">
        © 2026 GoldenGlow Salon Management System | Designed for Luxury <span>❤</span>
    </div>
</body>
</html>

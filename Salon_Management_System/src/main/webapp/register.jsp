<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>GoldenGlow Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">

<style>
/* ===== PAGE BACKGROUND ===== */
html, body{
    height: 100%;
}

body{
    margin: 0;
    background:
        url("https://img.freepik.com/premium-photo/luxurious-salon-interior-with-soft-tones-elegant-modern-design_1025753-152477.jpg?semt=ais_hybrid&w=740&q=80"); /* 🔁 change path */
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}

/* ===============================
   REGISTER FORM ONLY (SCOPED)
================================ */

/* center wrapper (safe) */
.center{
margin-top:40px;
    display: flex;
    align-items: center;
    justify-content: center;

    padding-top: 50px;   /* navbar height */
    padding-bottom: 10px; /* footer height */

    box-sizing: border-box;
}
@media (max-width:768px){
    .center{
        padding-top:95px;
        padding-bottom:80px;
    }
}


/* card – scoped */
.center .card{
	max-width:720px;        /* ⬅️ smaller card */
    padding:40px 20px;      /* ⬅️ less inner space */
    width:100%;
    background:rgba(18,18,18,.88);
    border-radius:20px;
    border:1px solid rgba(212,175,55,.35);
    backdrop-filter:blur(20px);
    box-shadow:
        0 0 70px rgba(212,175,55,.12),
        inset 0 0 30px rgba(212,175,55,.05);
    animation:registerFadeUp 1.1s ease forwards;
}

/* animation */
@keyframes registerFadeUp{
    from{
        opacity:0;
        transform:translateY(35px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* title */
.center .card .title{
    text-align:center;
    font-size:40px;
    letter-spacing:2px;
    margin-bottom:12px;
    color:#d4af37;
    text-shadow:
        0 0 14px rgba(212,175,55,.6),
        0 0 28px rgba(212,175,55,.3);
    animation:titlePulse 2.8s ease-in-out infinite alternate;
}

@keyframes titlePulse{
    from{ text-shadow:0 0 12px rgba(212,175,55,.45); }
    to{ text-shadow:0 0 26px rgba(212,175,55,.85); }
}

/* labels */
.center .card label{
    font-size:14px;
    letter-spacing:1px;
    color:#cfae5c;
}

/* input group */
.center .card .input-group-text{
    background:transparent;
    border:none;
    border-bottom:1px solid rgba(212,175,55,.45);
    color:#d4af37;
    transition:.3s ease;
}

/* inputs */
.center .card .form-control{
    background:transparent !important;
    border:none;
    border-bottom:1px solid rgba(212,175,55,.45);
    border-radius:0;
    color:#fff !important;
    padding:12px 8px;
    transition:.35s ease;
}

.center .card .form-control::placeholder{
    color:#777;
}

/* hover & focus */
.center .card .form-control:focus,
.center .card .form-control:hover{
    box-shadow:none;
    border-bottom-color:#ffd65c;
}

/* icon glow */
.center .card .input-group:hover .input-group-text{
    color:#ffd65c;
    text-shadow:0 0 8px rgba(255,215,0,.6);
}

/* eye icon */
.center .card .eye{
    cursor:pointer;
    transition:.3s ease;
}

.center .card .eye:hover{
    color:#ffd65c;
    transform:scale(1.15);
}

/* register button */
.center .card .btn-gold{
    margin-top:28px;
    background:linear-gradient(120deg,#c9a24d,#ffd65c,#c9a24d);
    background-size:200%;
    color:#000;
    border:none;
    font-weight:700;
    letter-spacing:3px;
    padding:16px;
    border-radius:10px;
    transition:.45s ease;
    animation:goldSlide 3s linear infinite;
}

@keyframes goldSlide{
    0%{ background-position:left; }
    100%{ background-position:right; }
}

.center .card .btn-gold:hover{
    transform:translateY(-3px);
    box-shadow:
        0 0 24px rgba(212,175,55,.8),
        0 0 48px rgba(212,175,55,.4);
}

/* alerts inside form only */
.center .card .alert{
    border-radius:10px;
    border:none;
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

<div class="center">

<div class="card">

<div class="title">
<i class="fa fa-user-plus"></i> Create Account
</div>

<% if(request.getParameter("error")!=null){ %>
<div class="alert alert-danger text-center">
<%=request.getParameter("error")%>
</div>
<% } %>

<% if(request.getParameter("msg")!=null){ %>
<div class="alert alert-success text-center">
<%=request.getParameter("msg")%>
</div>
<% } %>

<form action="<%= request.getContextPath() %>/RegisterServlet"
method="post" autocomplete="off">

<div class="row">

<!-- NAME -->
<div class="col-md-6 mb-3">
<label>Full Name</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-user"></i></span>
<input type="text" name="name" class="form-control"
required minlength="3" maxlength="50" autocomplete="off">
</div>
</div>

<!-- EMAIL -->
<div class="col-md-6 mb-3">
<label>Email</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-envelope"></i></span>
<input type="email" name="email" class="form-control"
required autocomplete="off">
</div>
</div>

<!-- PASSWORD -->
<div class="col-md-6 mb-3">
<label>Password</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-lock"></i></span>
<input type="password" id="pass" name="password"
class="form-control" required minlength="6"
autocomplete="new-password">
<span class="input-group-text eye" onclick="togglePass('pass',this)">
<i class="fa fa-eye"></i>
</span>
</div>
</div>

<!-- CONFIRM PASSWORD -->
<div class="col-md-6 mb-3">
<label>Confirm Password</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-lock"></i></span>
<input type="password" id="cpass" class="form-control"
required autocomplete="new-password">
<span class="input-group-text eye" onclick="togglePass('cpass',this)">
<i class="fa fa-eye"></i>
</span>
</div>
</div>

<!-- PHONE -->
<div class="col-md-12 mb-3">
<label>Phone</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-phone"></i></span>
<input type="text" name="phone" class="form-control"
pattern="[0-9]{10}" maxlength="10"
placeholder="10 digit number" autocomplete="off">
</div>
</div>

</div>

<button type="submit" class="btn btn-gold w-100 mt-2">
Register Now
</button>

</form>

</div>
</div>

<div class="footer-bottom">
        © 2026 GoldenGlow Salon Management System | Designed for Luxury <span>❤</span>
    </div>

<script>
function togglePass(id,el){
    const input=document.getElementById(id);
    const icon=el.querySelector("i");
    if(input.type==="password"){
        input.type="text";
        icon.classList.replace("fa-eye","fa-eye-slash");
    }else{
        input.type="password";
        icon.classList.replace("fa-eye-slash","fa-eye");
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

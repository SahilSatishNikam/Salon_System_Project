<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <title>Royal Thai Salon</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
  <style>
  /* Optional: give hero content some breathing room so text isn’t hidden behind navbar */
.hero .container {
    padding-top: 90px; 
    margin-bottom:20px; /* adjust based on your navbar height */
}

/* Glassy premium navbar background */
.glass-nav {
    background: rgba(0, 0, 0, 0.8) !important;
    background:transprent;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255, 215, 0, 0.18);
}

/* Brand container */
.brand-premium {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
}

/* Brand glow */
.brand-glow {
    text-shadow: 0 0 10px rgba(255, 215, 0, 0.55);
    transition: 0.3s ease;
}
.brand-glow:hover {
    text-shadow: 0 0 22px rgba(255, 215, 0, 0.95);
}

/* Brand text */
.brand-text {
    font-size: 1.5rem;
    font-weight: 800;
    letter-spacing: 0.6px;
    line-height: 1;
}

/* Gold gradient for Glow */
.brand-accent {
    background: linear-gradient(135deg, #ffd700, #ffb700, #fff1a8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* Big gold scissors */
.scissor-lg {
    width: 48px;
    height: 48px;
    min-width: 48px;
    display: inline-block;
    filter: drop-shadow(0 0 12px rgba(255, 215, 0, 0.95));
    transition: transform 0.25s ease, filter 0.25s ease;
}

/* Hover animation */
.brand-premium:hover .scissor-lg {
    transform: rotate(-10deg) scale(1.1);
    filter: drop-shadow(0 0 22px rgba(255, 215, 0, 1));
}

/* Nav underline animation */
.nav-underline {
    position: relative;
    padding-bottom: 4px;
}
.nav-underline::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 0%;
    height: 2px;
    background: linear-gradient(90deg, gold, #ffcc33);
    transition: width 0.3s ease;
}
.nav-underline:hover::after,
.nav-underline.active::after {
    width: 100%;
}

/* Make links visible on dark bg */
.navbar-dark .navbar-nav .nav-link {
    color: #f5f5f5 !important;
    font-weight: 500;
    opacity: 0.95;
    transition: 0.25s ease;
}
.navbar-dark .navbar-nav .nav-link:hover {
    color: gold !important;
    text-shadow: 0 0 8px rgba(255, 215, 0, 0.6);
}
.navbar-dark .navbar-nav .nav-link.active {
    color: gold !important;
}

/* Buttons glow */
.glow-btn {
    background: linear-gradient(135deg, gold, #ffcc33);
    color: #000 !important;
    border: none;
    box-shadow: 0 0 10px rgba(255, 215, 0, 0.55);
    transition: 0.3s ease;
}
.glow-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 20px rgba(255, 215, 0, 0.95);
}
.glow-hover:hover {
    box-shadow: 0 0 12px rgba(255, 255, 255, 0.5);
    transform: translateY(-2px);
}

/* Toggler visibility */
.navbar-dark .navbar-toggler {
    border-color: rgba(255,255,255,0.35);
}
.navbar-dark .navbar-toggler-icon {
    filter: brightness(1.6);
}

/* Mobile tuning */
@media (max-width: 576px) {
    .brand-text {
        font-size: 1.2rem;
    }
    .scissor-lg {
        width: 40px;
        height: 40px;
        min-width: 40px;
    }
}
.navbar{
      padding-top: 6px !important;
    padding-bottom: 6px !important;     
  }
  </style>
</head>
<body>

<!-- HEADER -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top shadow-lg glass-nav">
    <div class="container">
     <a class="navbar-brand fw-bold gold brand-glow brand-premium" href="${pageContext.request.contextPath}/index.jsp">
    <span class="brand-icon gold-icon">
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
                    <a class="nav-link nav-underline" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-underline" href="${pageContext.request.contextPath}/about.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-underline" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
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

</body>
</html>
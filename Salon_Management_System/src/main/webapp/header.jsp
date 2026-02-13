<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <title>Golden Glow Salon</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="css/header.css">
    
<style>
 /* ===== REGISTER BUTTON GOLDEN ===== */
.btn-gold{
    background: linear-gradient(135deg, #d4af37, #f5e6b0);
    color: #000;
    font-weight: 600;
    border: none;
    border-radius: 30px;   /* rounded */
    padding: 6px 18px;
}

.btn-gold:hover{
    background: linear-gradient(135deg, #f5e6b0, #d4af37);
    color: #000;
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
                <svg class="scissor-lg" viewBox="0 0 24 24"
                     xmlns="http://www.w3.org/2000/svg">
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

                <!-- HOME -->
                <li class="nav-item">
                    <a class="nav-link nav-underline 
                        <%= request.getRequestURI().contains("index.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/index.jsp">
                        Home
                    </a>
                </li>

                <!-- ABOUT -->
                <li class="nav-item">
                    <a class="nav-link nav-underline 
                        <%= request.getRequestURI().contains("about.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/about.jsp">
                        About
                    </a>
                </li>

                <!-- CONTACT -->
                <li class="nav-item">
                    <a class="nav-link nav-underline 
                        <%= request.getRequestURI().contains("contact.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/contact.jsp">
                        Contact
                    </a>
                </li>

                <!-- LOGIN -->
                <li class="nav-item">
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3 glow-hover"
                       href="${pageContext.request.contextPath}/login.jsp">
                        Login
                    </a>
                </li>

                <!-- REGISTER -->
                <li class="nav-item">
                    <a class="btn btn-gold btn-sm rounded-pill px-3 glow-btn"
                       href="${pageContext.request.contextPath}/register.jsp">
                        Register
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>

</body>
</html>

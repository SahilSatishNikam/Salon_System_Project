<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>User Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* ===== NAVBAR (SAME AS YOUR IMAGE) ===== */
.navbar{
    background:#000;
    padding:10px 40px;
    border-bottom:1px solid rgba(201,162,39,.3);
}

.navbar-brand{
    color:white;
    font-weight:bold;
    font-size:20px;
}

.navbar-brand span{
    color:#c9a227;
}

.nav-link{
    color:white !important;
    margin-right:18px;
}

.nav-link:hover{
    color:#c9a227 !important;
}

.login-btn{
    border:1px solid white;
    color:white;
    border-radius:20px;
    padding:5px 18px;
    text-decoration:none;
    margin-right:10px;
}

.register-btn{
    background:#c9a227;
    color:black;
    border-radius:20px;
    padding:5px 18px;
    text-decoration:none;
}

/* ===== PAGE CENTER ===== */
body{
    background:#0f1720;
    color:white;
}

.page-wrapper{
    min-height:88vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

/* ===== ANIMATED GOLD CARD ===== */
.card{
    background:#0b1118;
    border-radius:22px;
    position:relative;
    overflow:hidden;
}

/* MOVING GOLD LINE */
.card::before{
    content:'';
    position:absolute;
    top:-50%;
    left:-50%;
    width:200%;
    height:200%;

    background:linear-gradient(
        60deg,
        transparent,
        #c9a227,
        transparent
    );

    animation:rotate 5s linear infinite;
}

@keyframes rotate{
    from{ transform:rotate(0deg); }
    to{ transform:rotate(360deg); }
}

/* inner cover */
.card::after{
    content:'';
    position:absolute;
    inset:3px;
    background:#0b1118;
    border-radius:20px;
}

/* keep content above */
.card *{
    position:relative;
    z-index:2;
}

/* ===== FORM ===== */
.form-control{
    background:#10171f !important;
    border:1px solid #1c2a38;
    color:white !important;
}

.form-control:focus{
    border-color:#c9a227;
    box-shadow:0 0 8px rgba(201,162,39,.6);
}

label{
    color:#c9a227;
    font-size:15px;
}

/* ===== BUTTON ===== */
.btn-success{
    background:#c9a227;
    border:none;

    color:black !important;
    font-weight:bold;
}

.btn-success:hover{
    background:#e6b82e;
    box-shadow:0 0 12px #c9a227;
}

/* ===== CLEAR TEXT FIX ===== */
.title-text{
    color:white;
    font-weight:bold;
}

.bottom-text{
    color:white;
    font-size:14px;
}

.bottom-text a{
    color:#c9a227 !important;
    font-weight:bold;
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

<!-- ===== NAVBAR ===== -->
<nav class="navbar d-flex justify-content-between">
    <div class="navbar-brand">
        <span>Golden</span>Glow
    </div>

    <div>
        <a class="nav-link d-inline" href="index.jsp">Home</a>
        <a class="nav-link d-inline" href="about.jsp">About</a>
        <a class="nav-link d-inline" href="contact.jsp">Contact</a>

        <a href="login.jsp" class="login-btn">Login</a>
        <a href="register.jsp" class="register-btn">Register</a>
    </div>
</nav>

<!-- ===== CENTER SECTION ===== -->
<div class="page-wrapper">

<div style="width:100%; max-width:500px;">

<div class="card p-4">

<h3 class="text-center mb-3 title-text">User Registration</h3>

<% if(request.getParameter("msg")!=null){ %>
<div class="alert alert-info">
<%=request.getParameter("msg")%>
</div>
<% } %>

<form action="<%= request.getContextPath() %>/RegisterServlet" method="post">

<div class="mb-3">
<label>Name</label>
<input type="text" name="name" class="form-control" required>
</div>

<div class="mb-3">
<label>Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="mb-3">
<label>Password</label>
<input type="password" name="password" class="form-control" required>
</div>

<div class="mb-3">
<label>Phone</label>
<input type="text" name="phone" class="form-control">
</div>

<div class="mb-3">
<label>Select Role</label>
<select name="role" class="form-control" required>
<option value="">--Select Role--</option>
<option value="admin">Admin</option>
<option value="user">User</option>
<option value="therapist">Therapist</option>
</select>
</div>

<button type="submit" class="btn btn-success w-100">
Register
</button>

</form>

<div class="text-center mt-3 bottom-text">
Already registered?
<a href="login.jsp">Login</a>
</div>

</div>
</div>

</div>

<!-- ===== FOOTER ===== -->
<div class="footer">
© 2026 GoldenGlow Salon | All Rights Reserved
</div>

</body>
</html>

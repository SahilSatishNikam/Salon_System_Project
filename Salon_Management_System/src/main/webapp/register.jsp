<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>User Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* ===== GLOBAL ===== */
body{
    min-height:100vh;
    margin:0;
    background:
      linear-gradient(rgba(0,0,0,.75),rgba(0,0,0,.75)),
      url("https://wallpapers.com/images/hd/luxurious-aesthetic-hair-salon-fouu8bx77gcoygos.jpg");
    background-size:cover;
    background-position:center;
    font-family:'Poppins',sans-serif;
    color:#e6d38a;
}

/* ===== NAVBAR ===== */
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

/* ===== CENTER WRAPPER ===== */
.page-wrapper{
    min-height:85vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:80px 20px;   /* 👈 ADDED: space from top & bottom */
}


/* ===== GLASS CARD ===== */
.card{
    width:100%;
    max-width:520px;
    background:rgba(20,20,20,.78);
    border-radius:26px;
    padding:40px;
    box-shadow:0 0 35px rgba(229,198,109,.25);
    border:1px solid rgba(229,198,109,.35);
    backdrop-filter:blur(18px);
}

/* ===== HEADINGS ===== */
.title-text{
    color:#f0d14a;
    font-size:30px;
    font-weight:700;
    margin-bottom:6px;
}
.subtitle{
    color:#cfcfcf;
    font-size:14px;
    margin-bottom:30px;
}

/* ===== LABELS ===== */
label{
    color:#e6d38a;
    font-size:13px;
    margin-bottom:6px;
}

/* ===== INPUTS ===== */
.form-control{
    background:rgba(0,0,0,.55)!important;
    border:1px solid rgba(255,215,100,.25);
    color:#fff!important;
    border-radius:14px;
    padding:12px 14px;
}
.form-control::placeholder{
    color:#aaa;
}
.form-control:focus{
    border-color:#f0d14a;
    box-shadow:0 0 10px rgba(240,209,74,.6);
    background:rgba(0,0,0,.65)!important;
}

/* ===== BUTTON ===== */
.btn-success{
    background:linear-gradient(135deg,#ffd84d,#e6b82e);
    border:none;
    border-radius:30px;
    padding:14px;
    font-size:15px;
    font-weight:700;
    letter-spacing:1px;
    color:#000!important;
    transition:.3s;
}
.btn-success:hover{
    box-shadow:0 0 22px rgba(240,209,74,.8);
    transform:translateY(-1px);
}

/* ===== BOTTOM TEXT ===== */
.bottom-text{
    color:#cfcfcf;
    font-size:14px;
}
.bottom-text a{
    color:#f0d14a!important;
    font-weight:600;
    text-decoration:none;
}

/* ===== FOOTER ===== */
.footer{
    text-align:center;
    padding:14px;
    font-size:13px;
    color:#999;
    border-top:1px solid rgba(255,215,100,.25);
    background:rgba(0,0,0,.65);
}

</style>
</head>

<body>

<!-- ===== NAVBAR ===== -->
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

<!-- ===== CENTER SECTION ===== -->
<div class="page-wrapper">

<div style="width:100%; max-width:500px;">

<div class="card p-4">

<h3 class="text-center mb-3 title-text">Registration</h3>

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

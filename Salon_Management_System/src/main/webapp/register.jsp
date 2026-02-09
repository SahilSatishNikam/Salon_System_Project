<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>GoldenGlow Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{
    height:100vh;
    margin:0;
    display:flex;
    flex-direction:column;
    background:
    linear-gradient(rgba(0,0,0,.75),rgba(0,0,0,.75)),
    url("https://wallpapers.com/images/hd/luxurious-aesthetic-hair-salon-fouu8bx77gcoygos.jpg");
    background-size:cover;
    font-family:'Poppins',sans-serif;
    color:#fff;
}

/* NAVBAR */
.navbar{
    padding:12px 40px;
    background:rgba(0,0,0,.7);
}
.navbar-brand{
    color:#f0d14a;
    font-weight:700;
    font-size:24px;
}

/* CENTER */
.center{
    flex:1;
    display:flex;
    align-items:center;
    justify-content:center;
}

/* CARD */
.card{
    width:950px;
    background:rgba(20,20,20,.85);
    border-radius:25px;
    padding:35px;
    border:1px solid rgba(229,198,109,.35);
    box-shadow:0 0 35px rgba(229,198,109,.25);
    backdrop-filter:blur(15px);
    animation:fadeIn .6s ease;
    color:#fff;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

/* TITLE */
.title{
    text-align:center;
    font-size:28px;
    color:#f0d14a;
    font-weight:700;
    margin-bottom:25px;
}

/* INPUT */
.input-group-text{
    background:#000;
    border:1px solid rgba(255,215,100,.25);
    color:#f0d14a;
}

.form-control{
    background:#000!important;
    border:1px solid rgba(255,215,100,.25);
    color:#fff!important;
}
.form-control:focus{
    border-color:#f0d14a;
    box-shadow:0 0 10px rgba(240,209,74,.7);
}

/* BUTTON */
.btn-gold{
    background:linear-gradient(135deg,#ffd84d,#e6b82e);
    border:none;
    font-weight:700;
    color:#000;
    padding:12px;
    border-radius:30px;
    transition:.3s;
}
.btn-gold:hover{
    box-shadow:0 0 20px rgba(240,209,74,.8);
    transform:translateY(-1px);
}

/* LABEL */
label{
    font-size:13px;
    margin-bottom:4px;
   
}

/* FOOTER */
.footer{
    text-align:center;
    font-size:12px;
    padding:6px;
    background:#000;
}

/* SHOW PASSWORD */
.eye{
    cursor:pointer;
}
</style>
</head>

<body>

<nav class="navbar">
    <span class="navbar-brand">GoldenGlow</span>
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

<div class="footer">
© 2026 GoldenGlow Salon
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

</body>
</html>

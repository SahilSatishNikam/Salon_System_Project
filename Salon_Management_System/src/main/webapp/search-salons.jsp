<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<title>Search Salons | SalonEase</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    min-height:100vh;
    background:radial-gradient(circle at top,#111,#000);
    font-family:'Segoe UI',sans-serif;
    color:#fff;
}

/* Title */
.page-title{
    text-align:center;
    color:#ffd700;
    font-weight:700;
    letter-spacing:1px;
    margin-top:60px; /* TOP → DOWN */
    margin-bottom:40px;
}

/* Search box */
.search-box{
    background:#0c0c0c;
    padding:35px 30px;
    border-radius:28px;
    border:1px solid #d4af37;
    max-width:900px;
    margin:0 auto 50px auto; /* CENTER */
    box-shadow:
        0 0 25px rgba(212,175,55,.35),
        inset 0 0 15px rgba(255,215,0,.15);
    position:relative;
    overflow:hidden;
}

/* Shining animation */
.search-box::before{
    content:'';
    position:absolute;
    top:-50%;
    left:-50%;
    width:200%;
    height:200%;
    background:linear-gradient(120deg,
        transparent,
        rgba(255,215,0,.25),
        transparent);
    animation:shine 6s infinite linear;
}

@keyframes shine{
    from{transform:translateX(-100%);}
    to{transform:translateX(100%);}
}

/* Input wrapper */
.input-box{
    position:relative;
}

/* Icons */
.input-box i{
    position:absolute;
    top:50%;
    left:18px;
    transform:translateY(-50%);
    color:#ffd700;
}

/* Inputs */
.search-box input{
    padding:12px 20px 12px 45px;
    background:#000;
    border:1px solid #d4af37;
    border-radius:35px;
    color:#fff;
    text-align:left;
}

.search-box input::placeholder{
    color:#bbb;
    opacity:1;
}

.search-box input:focus{
    border-color:#ffd700;
    box-shadow:0 0 15px rgba(255,215,0,.9);
    background:#000;
    color:#fff;
}

/* Button */
.search-btn{
    border:none;
    border-radius:35px;
    padding:12px;
    font-weight:700;
    letter-spacing:.5px;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
    transition:.3s;
}

.search-btn:hover{
    transform:translateY(-2px) scale(1.05);
    box-shadow:0 0 25px rgba(255,215,0,1);
}

/* Salon card */
.salon-card{
    background:#0b0b0b;
    border-radius:25px;
    padding:20px;
    margin-bottom:30px;
    display:flex;
    gap:20px;
    align-items:center;
    border:1px solid rgba(212,175,55,.4);
    box-shadow:0 0 30px rgba(212,175,55,.25);
    transition:.3s;
    position:relative;
}

.salon-card:hover{
    transform:translateY(-8px);
    box-shadow:0 0 45px rgba(255,215,0,.8);
}

/* Image */
.salon-card img{
    width:150px;
    height:150px;
    object-fit:cover;
    border-radius:18px;
    border:3px solid #d4af37;
}

/* Heart */
.fav{
    position:absolute;
    top:18px;
    right:22px;
    color:#555;
    font-size:22px;
    cursor:pointer;
}
.fav:hover{color:#ffd700}

/* Text */
.salon-card h3{color:#ffd700}
.rating i{color:#ffd700}
.salon-card p{color:#ddd;margin:4px 0}

/* Buttons */
.gold-btn{
    display:inline-block;
    margin-top:12px;
    padding:9px 20px;
    border-radius:30px;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
    font-weight:600;
    text-decoration:none;
}

.outline-btn{
    display:inline-block;
    margin-top:12px;
    padding:9px 20px;
    border-radius:30px;
    border:1px solid #ffd700;
    color:#ffd700;
    text-decoration:none;
    margin-left:10px;
}

.outline-btn:hover{
    background:#ffd700;
    color:#000;
}

/* Responsive */
@media(max-width:768px){
    .salon-card{
        flex-direction:column;
        text-align:center;
    }
}
</style>
</head>

<body class="container">

<h2 class="page-title">
    <i class="fa-solid fa-scissors"></i> Find Your Perfect Salon
</h2>

<!-- SEARCH -->
<div class="search-box">
<form method="get" action="search-salons.jsp"
      class="row g-4 justify-content-center align-items-center">

    <div class="col-md-4 input-box">
        <i class="fa-solid fa-store"></i>
        <input type="text" name="name" class="form-control"
               placeholder="Salon Name"
               value="<%=request.getParameter("name")!=null?request.getParameter("name"):""%>">
    </div>

    <div class="col-md-4 input-box">
        <i class="fa-solid fa-location-dot"></i>
        <input type="text" name="location" class="form-control"
               placeholder="Location"
               value="<%=request.getParameter("location")!=null?request.getParameter("location"):""%>">
    </div>

    <div class="col-md-2">
        <button class="search-btn w-100">
            <i class="fa fa-magnifying-glass"></i> Search
        </button>
    </div>
</form>
</div>

<%
SalonDAO salonDAO = new SalonDAO();
String name = request.getParameter("name");
String location = request.getParameter("location");

boolean searched = (name!=null && !name.trim().isEmpty()) ||
                   (location!=null && !location.trim().isEmpty());

List<Salon> salons = searched ?
        salonDAO.searchSalons(name,location,null) :
        salonDAO.getAllSalons();
%>

<% if(!salons.isEmpty()){
   for(Salon s: salons){ %>

<div class="salon-card">

<i class="fa-solid fa-heart fav"></i>

<div>
    <% if(s.getImage()!=null){ %>
        <img src="SalonImageServlet?id=<%=s.getId()%>">
    <% } else { %>
        <img src="../images/no-image.png">
    <% } %>
</div>

<div>
    <h3><%=s.getName()%></h3>
    <div class="rating">
        <i class="fa fa-star"></i>
        <i class="fa fa-star"></i>
        <i class="fa fa-star"></i>
        <i class="fa fa-star"></i>
        <i class="fa fa-star-half-stroke"></i>
    </div>
    <p><b>Location:</b> <%=s.getAddress()%></p>
    <p><b>Phone:</b> <%=s.getPhone()%></p>

    <a href="BookAppointmentServlet?salonId=<%=s.getId()%>" class="gold-btn">Book Now</a>
    <a href="salon-details.jsp?salonId=<%=s.getId()%>" class="outline-btn">Explore</a>
</div>
</div>

<% } } else { %>
<p class="text-center text-warning">No salons found</p>
<% } %>

</body>
</html>
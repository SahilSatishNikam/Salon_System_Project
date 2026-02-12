<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Salons | Admin Panel</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>

/* =====================================================
   YOUR ORIGINAL CSS (UNCHANGED)
===================================================== */

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:"Times New Roman", Times, serif;
    background:linear-gradient(135deg,#0f0f0f,#1a1a1a);
    color:#fff;
    display:flex;
    overflow-x:hidden;
}

/* Smooth Scrollbar */
::-webkit-scrollbar{ width:8px; }
::-webkit-scrollbar-track{ background:#111; }
::-webkit-scrollbar-thumb{
    background:linear-gradient(#c9a227,#FFD700);
    border-radius:10px;
}

/* =========================================
   SIDEBAR CONTAINER
========================================= */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    backdrop-filter:blur(6px);
    padding-top:10px;
    overflow:hidden;

    display:flex;
    flex-direction:column;
    justify-content:space-between;

    animation:sidebarSlide 0.8s ease;
}

/* Golden vertical glow line */
.sidebar::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:3px;
    height:100%;
    background:linear-gradient(to bottom,#d4af37,#ffd700,#d4af37);
    box-shadow:0 0 15px #d4af37;
}

/* =========================================
   TOP SECTION (LOGO + MENU)
========================================= */
.sidebar-top{
    display:flex;
    flex-direction:column;
}

/* Logo */
.logo{
    padding:26px 22px;
    display:flex;
    align-items:center;
    gap:10px;
}

.logo-img{
    width:30px;
    filter:drop-shadow(0 0 6px #c9a227);
    transition:0.4s;
}

.logo:hover .logo-img{
    transform:rotate(10deg) scale(1.1);
}

.s1{
    color:#ffffff;
    font-weight:bold;
    font-size:19px;
}

.s2{
    color:#c9a227;
    font-size:19px;
}

/* =========================================
   MENU LINKS
========================================= */
.sidebar a{
    position:relative;
    display:flex;
    align-items:center;
    padding:16px 26px;
    margin:6px 10px;
    border-radius:14px;
    font-size:17px;
    color:#ffffff;
    text-decoration:none;
    transition:all 0.4s ease;
    overflow:hidden;
}

/* Hover golden background animation */
.sidebar a::before{
    content:"";
    position:absolute;
    left:0;
    top:0;
    height:100%;
    width:0;
    background:linear-gradient(to right,#c9a227,#ffd700);
    opacity:0.15;
    transition:0.4s ease;
}

.sidebar a:hover::before{
    width:100%;
}

/* Icon */
.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.4s ease;
}

/* Hover Effect */
.sidebar a:hover{
    color:#ffd700;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#ffd700;
    transform:scale(1.2);
}

/* =========================================
   ACTIVE MENU ITEM
========================================= */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid #ffd700;

    box-shadow:
        0 0 12px rgba(201,162,39,0.4),
        inset 0 0 10px rgba(201,162,39,0.3);

    animation:activePulse 2s infinite;
}

/* =========================================
   LOGOUT BUTTON (BOTTOM)
========================================= */
.logout{
    margin:20px 10px;
    padding:16px;
    border-radius:14px;
    font-size:17px;
    font-weight:bold;

    display:flex;
    align-items:center;
    justify-content:center;

    background:linear-gradient(145deg,#2a0000,#110000);
    border:1px solid rgba(255,80,80,0.4);
    color:#ffdddd;

    transition:all 0.4s ease;
    text-decoration:none;
}

.logout i{
    margin-right:12px;
    color:#ff6b6b;
    transition:0.4s;
}

.logout:hover{
    background:linear-gradient(145deg,#5a0000,#2a0000);
    color:#ffffff;
    transform:translateY(-4px);

    box-shadow:
        0 0 20px rgba(255,80,80,0.6),
        inset 0 0 10px rgba(255,100,100,0.3);
}

.logout:hover i{
    color:#ffffff;
    transform:rotate(-10deg) scale(1.2);
}

/* =========================================
   ANIMATIONS
========================================= */

/* Sidebar Slide */
@keyframes sidebarSlide{
    from{
        transform:translateX(-100%);
        opacity:0;
    }
    to{
        transform:translateX(0);
        opacity:1;
    }
}

/* Active Glow Pulse */
@keyframes activePulse{
    0%,100%{
        box-shadow:
        0 0 10px rgba(201,162,39,0.3),
        inset 0 0 8px rgba(201,162,39,0.2);
    }
    50%{
        box-shadow:
        0 0 20px rgba(255,215,0,0.6),
        inset 0 0 12px rgba(255,215,0,0.4);
    }
}

/* =====================================================
   MAIN CONTENT
===================================================== */

.main-content{
    margin-left:260px;
    padding:50px 60px;
    width:100%;
    animation:fadeUp 0.8s ease;
}

@keyframes fadeUp{
    from{opacity:0; transform:translateY(30px);}
    to{opacity:1; transform:translateY(0);}
}

/* =====================================================
   FORM
===================================================== */

.salon-form{
    margin-bottom:60px;
}

.salon-form h3{
    color:#FFD700;
    margin-bottom:30px;
    animation:fadeUp 0.8s ease;
}

/* Inputs */
.form-row{
    display:flex;
    gap:25px;
    margin-bottom:20px;
}

.form-row input[type="text"]{
    flex:1;
    padding:15px 18px;
    border-radius:12px;
    border:none;
    background:#f2f2f2;
    transition:0.3s;
}

.form-row input:focus{
    outline:none;
    transform:translateY(-3px);
    box-shadow:0 0 0 3px rgba(255,215,0,0.4);
}

/* =====================================================
   UPLOAD BOX (Premium SaaS Effect)
===================================================== */

.upload-row{
    display:flex;
    align-items:center;
    gap:30px;
}

.upload-box{
    flex:1;
    border:2px dashed rgba(255,215,0,0.6);
    border-radius:18px;
    padding:50px;
    background:rgba(255,255,255,0.02);
    cursor:pointer;
    transition:all 0.4s ease;
    display:flex;
    justify-content:center;
    align-items:center;
    position:relative;
    overflow:hidden;
}

/* subtle glowing animation */
.upload-box::before{
    content:"";
    position:absolute;
    width:200%;
    height:200%;
    background:radial-gradient(circle, rgba(255,215,0,0.15) 0%, transparent 70%);
    animation:rotateGlow 6s linear infinite;
}

@keyframes rotateGlow{
    from{transform:rotate(0deg);}
    to{transform:rotate(360deg);}
}

.upload-box:hover{
    background:rgba(255,215,0,0.06);
    border-color:#FFD700;
    box-shadow:0 0 35px rgba(255,215,0,0.2);
    transform:translateY(-5px);
}

.upload-content{
    text-align:center;
    position:relative;
    z-index:2;
}

.upload-content i{
    font-size:42px;
    color:#FFD700;
    margin-bottom:15px;
    transition:0.3s;
}

.upload-box:hover i{
    transform:scale(1.2);
}

.upload-content p{
    color:#FFD700;
    font-weight:bold;
    font-size:18px;
}

.upload-content span{
    font-size:12px;
    color:#bbb;
}

/* =====================================================
   ADD BUTTON
===================================================== */

.add-btn{
    background:linear-gradient(45deg,#FFD700,#c9a227);
    color:#000;
    border:none;
    padding:20px 40px;
    border-radius:16px;
    font-weight:bold;
    transition:0.4s;
    position:relative;
    overflow:hidden;
}

.add-btn::before{
    content:"";
    position:absolute;
    left:-100%;
    top:0;
    width:100%;
    height:100%;
    background:linear-gradient(120deg,transparent,rgba(255,255,255,0.6),transparent);
    transition:0.6s;
}

.add-btn:hover::before{
    left:100%;
}

.add-btn:hover{
    transform:translateY(-4px);
    box-shadow:0 15px 35px rgba(255,215,0,0.6);
}

/* =====================================================
   SALON CARDS
===================================================== */

.card.bg-dark{
    background:#141414 !important;
    border-radius:20px;
    border:1px solid rgba(255,215,0,0.15);
    transition:all 0.4s ease;
    overflow:hidden;
    position:relative;
}

.card.bg-dark:hover{
    transform:translateY(-10px);
    box-shadow:0 20px 45px rgba(255,215,0,0.25);
    border-color:#FFD700;
}

/* Image zoom */
.card-img-top{
    height:220px;
    object-fit:cover;
    transition:0.4s;
}

.card:hover .card-img-top{
    transform:scale(1.07);
}

/* Card text */
.card-title{
    color:#FFD700;
}

.card-body p{
    color:#ccc;
    font-size:14px;
}

/* =====================================================
   ACTION BUTTONS
===================================================== */

.actions a{
    background:#1f1f1f;
    padding:10px 14px;
    border-radius:12px;
    color:#FFD700;
    transition:0.3s ease;
}

.actions a:hover{
    background:#FFD700;
    color:#000;
    transform:scale(1.15);
}

</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="bi bi-scissors"></i> SalonEase</h2>
    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="manage-salons.jsp" class="active"><i class="bi bi-shop"></i> Manage Salons</a>
    <a href="visitedClients"><i class="bi bi-people"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="bi bi-person-badge"></i> Therapists</a>
    <a href="AdminAppointmentServlet"><i class="bi bi-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="bi bi-chat-left-text"></i> Feedback</a>
    <a href="reports.jsp"><i class="bi bi-bar-chart"></i> Reports</a>
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

<form method="post" action="AddSalonServlet" enctype="multipart/form-data" class="salon-form">
    <h3><i class="bi bi-plus-circle"></i> Add New Salon</h3>

    <div class="form-row">
        <input type="text" name="name" placeholder="Salon Name" required>
        <input type="text" name="email" placeholder="Email">
    </div>

    <div class="form-row">
        <input type="text" name="phone" placeholder="Phone">
        <input type="text" name="address" placeholder="Address">
    </div>

    <div class="upload-row">
        <label class="upload-box">
            <input type="file" name="image" required hidden>
            <div class="upload-content">
                <i class="bi bi-cloud-arrow-up-fill"></i>
                <p>Click to upload salon thumbnail</p>
            </div>
        </label>

        <button type="submit" class="add-btn">
            <i class="bi bi-plus-lg"></i> ADD SALON
        </button>
    </div>
</form>

<h2 class="mb-4"><i class="bi bi-shop"></i> All Salons</h2>
<div class="row g-4">

<%
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();
List<Salon> salons = salonDAO.getAllSalons();

for(Salon s : salons){
s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<div class="col-lg-4 col-md-6">
    <div class="card bg-dark text-white h-100">
        <% if(s.getImage()!=null){ %>
        <img src="SalonImageServlet?id=<%=s.getId()%>" class="card-img-top" style="height:220px;object-fit:cover;">
        <% } %>
        <div class="card-body d-flex flex-column">
            <h5 class="card-title"><%=s.getName()%></h5>
            <p><i class="bi bi-envelope"></i> <%=s.getEmail()%></p>
            <p><i class="bi bi-telephone"></i> <%=s.getPhone()%></p>
            <p><i class="bi bi-geo-alt"></i> <%=s.getAddress()%></p>

            <!-- ICON ACTIONS (Edit | Add Service | Delete) -->
            <div class="mt-auto d-flex justify-content-between actions">

                <a href="EditSalonServlet?id=<%=s.getId()%>" title="Edit">
                    <i class="bi bi-pencil-square"></i>
                </a>

                <a href="#"
                   data-bs-toggle="modal"
                   data-bs-target="#serviceModal-<%=s.getId()%>"
                   title="Add Service">
                    <i class="bi bi-plus-circle"></i>
                </a>

                <a href="DeleteSalonServlet?id=<%=s.getId()%>"
                   onclick="return confirm('Delete this salon?')"
                   title="Delete">
                    <i class="bi bi-trash"></i>
                </a>

            </div>
        </div>
    </div>
</div>

<!-- ADD SERVICE MODAL -->
<div class="modal fade" id="serviceModal-<%=s.getId()%>" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-white border-warning p-4">
            <h5 class="text-warning mb-3">
                Add Service - <%=s.getName()%>
            </h5>

            <form method="post" action="AddServiceServlet">
                <input type="hidden" name="salonId" value="<%=s.getId()%>">

                <input type="text" name="name" placeholder="Service Name"
                       class="form-control mb-3" required>

                <input type="text" name="description" placeholder="Description"
                       class="form-control mb-3">

                <input type="number" name="price" placeholder="Price"
                       step="0.01" class="form-control mb-3">

                <input type="number" name="durationMinutes"
                       placeholder="Duration (Minutes)"
                       class="form-control mb-3">

                <button type="submit" class="btn btn-warning w-100">
                    <i class="bi bi-plus"></i> Add Service
                </button>
            </form>
        </div>
    </div>
</div>

<% } %>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

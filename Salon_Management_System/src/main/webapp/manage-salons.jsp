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
/* ===== GENERAL ===== */
body {
    margin:0;
    font-family:'Poppins',sans-serif;
    background: linear-gradient(135deg, #0f0f0f, #1a1a1a);
    color:#fff;
    display:flex;
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

/* ===== MAIN CONTENT ===== */
.main-content {
    margin-left:250px;
    padding:40px;
    width:calc(100% - 250px);
}

/* ===== ADD SALON FORM ===== */
.salon-form {
    background: rgba(30,30,30,0.9);
    padding:30px;
    border-radius:20px;
    max-width:900px;
    margin-bottom:50px;
    border:2px solid #FFD700;
}
.salon-form h3 {
    text-align:center;
    color:#FFD700;
    margin-bottom:25px;
}
.salon-form .form-row {
    display:flex;
    gap:20px;
    margin-bottom:15px;
    flex-wrap:wrap;
}
.salon-form input {
    flex:1;
    padding:12px 15px;
    border-radius:12px;
    border:2px solid #FFD700;
    background:#111;
    color:#fff;
}
.salon-form input:focus {
    outline:none;
    box-shadow:0 0 15px rgba(255,215,0,.6);
}
.salon-form button {
    width:100%;
    padding:14px;
    font-weight:700;
    background:linear-gradient(45deg,#FFD700,#ffea00);
    border:none;
    border-radius:12px;
    color:#000;
}
.salon-form button:hover {
    box-shadow:0 8px 25px rgba(255,215,0,.8);
}

/* ===== SALON CARDS ===== */
.card.bg-dark {
    border-radius:25px;
    background: rgba(20,20,20,0.8);
    border:2px solid transparent;
    overflow:hidden;
    transition:0.3s;
}
.card.bg-dark:hover {
    transform:scale(1.04);
    border:2px solid #FFD700;
    box-shadow:0 15px 30px rgba(255,215,0,.4);
}
.card-img-top {
    height:220px;
    object-fit:cover;
    border-bottom:2px solid #FFD700;
}
.card-title {
    color:#FFD700;
    font-weight:700;
}
.actions a {
    font-size:1.4rem;
    transition:0.3s;
}
.actions a:hover {
    transform:scale(1.3);
    color:#ffea00;
}

/* ===== MODAL ===== */
.modal-content {
    background:#111;
    color:#fff;
    border:2px solid #FFD700;
}
.modal-content input {
    background:#222;
    border:2px solid #FFD700;
    color:#fff;
}
.modal-content button {
    background:linear-gradient(45deg,#FFD700,#ffea00);
    color:#000;
}

</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="bi bi-scissors"></i> SalonEase Admin</h2>
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

    <!-- ADD SALON -->
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
        <div class="form-row">
            <input type="file" name="image" required>
        </div>
        <button type="submit"><i class="bi bi-save"></i> Add Salon</button>
    </form>

    <!-- SALON LIST -->
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
                    <img src="SalonImageServlet?id=<%=s.getId()%>" class="card-img-top">
                <% } %>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%=s.getName()%></h5>
                    <p><i class="bi bi-envelope"></i> <%=s.getEmail()%></p>
                    <p><i class="bi bi-telephone"></i> <%=s.getPhone()%></p>
                    <p><i class="bi bi-geo-alt"></i> <%=s.getAddress()%></p>

                    <div class="mt-auto d-flex justify-content-between actions">
                        <a href="EditSalonServlet?id=<%=s.getId()%>"><i class="bi bi-pencil-square"></i></a>
                        <a href="DeleteSalonServlet?id=<%=s.getId()%>" 
                           onclick="return confirm('Delete this salon?')">
                           <i class="bi bi-trash"></i>
                        </a>
                        <a href="#" data-bs-toggle="modal" 
                           data-bs-target="#serviceModal-<%=s.getId()%>">
                           <i class="bi bi-scissors"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ADD SERVICE MODAL -->
        <div class="modal fade" id="serviceModal-<%=s.getId()%>" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content p-4">
                    <h5>Add Service - <%=s.getName()%></h5>
                    <form method="post" action="AddServiceServlet">
                        <input type="hidden" name="salonId" value="<%=s.getId()%>">
                        <input type="text" name="name" placeholder="Service Name" class="form-control mb-3" required>
                        <input type="text" name="description" placeholder="Description" class="form-control mb-3">
                        <input type="number" name="price" placeholder="Price" step="0.01" class="form-control mb-3">
                        <input type="number" name="durationMinutes" placeholder="Duration (Minutes)" class="form-control mb-3">
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

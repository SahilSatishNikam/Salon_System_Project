<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Therapist, model.Salon" %>

<%
    List<Therapist> therapists = (List<Therapist>) request.getAttribute("therapists");
    List<Salon> salons = (List<Salon>) request.getAttribute("salons");
    Therapist editTherapist = (Therapist) request.getAttribute("editTherapist");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Therapists</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
/* ================= GLOBAL ================= */
body{
    margin:0;
    background: radial-gradient(circle at top left,#111,#000);
    font-family:"Times New Roman", Times, serif;
    color:#e6c766;
    overflow-x:hidden;
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

/* ================= MAIN ================= */
.main{
    margin-left:260px;
    padding:40px;
}

.main h3{
    color:#FFD700;
    margin-bottom:25px;
    border-bottom:2px solid #FFD700;
    display:inline-block;
}

/* ================= CARD ================= */
.card{
    background:#141414;
    border:1px solid rgba(255,215,0,0.2);
    border-radius:15px;
}

/* ================= FORM ================= */
.form-control,
.form-select{
    background:#1a1a1a;
    border:1px solid #FFD700;
    color:#fff;
    font-family:"Times New Roman", Times, serif;
}

.form-control::placeholder{
    color:#bbb;
}

.form-control:focus,
.form-select:focus{
    background:#222;
    border-color:#FFD700;
    box-shadow:0 0 10px rgba(255,215,0,0.4);
}

.btn-gold{
    background:linear-gradient(45deg,#FFD700,#c9a227);
    border:none;
    padding:8px 25px;
    border-radius:25px;
    font-weight:bold;
}

.btn-gold:hover{
    transform:translateY(-2px);
    box-shadow:0 8px 15px rgba(255,215,0,0.4);
}

/* ================= TABLE ================= */
.table{
    background:#111;
    color:#ddd;
}

.table th{
    background:linear-gradient(90deg,#FFD700,#c9a227);
    color:#000;
}

.table tbody tr:hover{
    background:rgba(255,215,0,0.07);
}

/* ================= ICON BUTTONS ================= */
.btn-sm{
    border-radius:50%;
    width:36px;
    height:36px;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:0;
    transition:0.3s;
}

.btn-primary{
    background:#1a1a1a;
    border:1px solid #FFD700;
    color:#FFD700;
}

.btn-primary:hover{
    background:#FFD700;
    color:#000;
}

.btn-danger{
    background:#1a1a1a;
    border:1px solid #ff4d4d;
    color:#ff4d4d;
}

.btn-danger:hover{
    background:#ff4d4d;
    color:#fff;
}

.btn-approve{
    background:#14532d;
    color:#fff;
}

.btn-approve:hover{
    background:#198754;
}

.btn-reject{
    background:#6a1a1a;
    color:#fff;
}

.btn-reject:hover{
    background:#dc3545;
}

/* ================= RESPONSIVE ================= */
@media(max-width:768px){
    .sidebar{
        position:relative;
        width:100%;
        height:auto;
    }
    .main{
        margin-left:0;
    }
    .table{
        font-size:12px;
    }
}
    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2 style="font-size:25px;color:#F5A927"><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Main -->
<div class="main">

<h3>Manage Therapists</h3>

<!-- Form -->
<div class="card p-4 mb-4">
<form action="AdminTherapistServlet" method="post" class="row g-3">

<input type="hidden" name="action" value="<%= (editTherapist != null) ? "update" : "add" %>">
<% if(editTherapist != null){ %>
<input type="hidden" name="id" value="<%=editTherapist.getId()%>">
<% } %>

<div class="col-md-2">
<input class="form-control" name="name" placeholder="Name" required
value="<%= (editTherapist != null) ? editTherapist.getName() : "" %>">
</div>

<div class="col-md-2">
<input class="form-control" name="phone" placeholder="Phone" required
value="<%= (editTherapist != null) ? editTherapist.getPhone() : "" %>">
</div>

<div class="col-md-2">
<input class="form-control" name="email" placeholder="Email" required
value="<%= (editTherapist != null) ? editTherapist.getEmail() : "" %>">
</div>

<div class="col-md-2">
<input class="form-control" name="specialty" placeholder="Specialty"
value="<%= (editTherapist != null) ? editTherapist.getSpecialty() : "" %>">
</div>

<div class="col-md-2">
<select name="salonId" class="form-select" required>
<option value="">Assign Salon</option>
<% for(Salon s: salons){ %>
<option value="<%=s.getId()%>"
<%= (editTherapist != null && editTherapist.getSalonId()==s.getId())?"selected":"" %>>
<%=s.getName()%>
</option>
<% } %>
</select>
</div>

<div class="col-md-2">
<input type="password" class="form-control" name="password" placeholder="Password"
value="<%= (editTherapist != null) ? editTherapist.getPassword() : "" %>" required>
</div>

<div class="col-12">
<button class="btn btn-gold">
<%= (editTherapist != null) ? "Update Therapist" : "Add Therapist" %>
</button>
</div>

</form>
</div>

<!-- Table -->
<div class="card p-3">
<table class="table table-bordered table-hover text-center align-middle">
<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Phone</th>
<th>Email</th>
<th>Specialty</th>
<th>Salon</th>
<th>Status</th>
<th>Approved</th>
<th>Decision</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<% if(therapists!=null && !therapists.isEmpty()){
for(Therapist t:therapists){ %>

<tr>
<td><%=t.getId()%></td>
<td><%=t.getName()%></td>
<td><%=t.getPhone()%></td>
<td><%=t.getEmail()%></td>
<td><%=t.getSpecialty()%></td>
<td>
<% for(Salon s:salons){
if(s.getId()==t.getSalonId()){ out.print(s.getName()); break; }
} %>
</td>
<td><%=t.getStatus()%></td>
<td><%=t.getApproved()==1?"Yes":"No"%></td>
<td><%=t.getTherapistDecision()%></td>

<td class="text-nowrap">

<a href="AdminTherapistServlet?action=edit&id=<%=t.getId()%>"
class="btn btn-sm btn-primary" title="Edit">
<i class="fa fa-pen"></i>
</a>

<a href="AdminTherapistServlet?action=delete&id=<%=t.getId()%>"
class="btn btn-sm btn-danger"
onclick="return confirm('Are you sure?');"
title="Delete">
<i class="fa fa-trash"></i>
</a>

<% if(t.getApproved()!=1){ %>
<a href="AdminTherapistServlet?action=approve&id=<%=t.getId()%>"
class="btn btn-sm btn-approve" title="Approve">
<i class="fa fa-check"></i>
</a>

<a href="AdminTherapistServlet?action=reject&id=<%=t.getId()%>"
class="btn btn-sm btn-reject" title="Reject">
<i class="fa fa-times"></i>
</a>
<% } %>

</td>
</tr>

<% }} else { %>
<tr>
<td colspan="10">No therapists found</td>
</tr>
<% } %>

</tbody>
</table>
</div>

</div>
</body>
</html>

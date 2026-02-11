<%@ page import="model.Salon" %>
<%
    Salon salon = (Salon) request.getAttribute("salon");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Salon | Admin Panel</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== BODY ===== */
body {
    margin:0;
    font-family:'Poppins',sans-serif;
    background: linear-gradient(135deg, #0f0f0f, #1a1a1a);
    color:#fff;
    display:flex;
}

/* ===== SIDEBAR ===== */
.sidebar {
    width:250px;
    background:#000;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #FFD700;
    padding-top:10px;
}
.sidebar h2 {
    text-align:center;
    padding:20px;
    color:#FFD700;
    font-weight:600;
    border-bottom:1px solid #222;
    font-size:1.3rem;
}
.sidebar a {
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-weight:500;
    font-size:19px;
}
.sidebar a i { margin-right:12px; font-size:1.1rem; }
.sidebar a:hover, .sidebar a.active { background:#FFD700; color:#000; padding-left:28px; }

/* ===== MAIN CONTENT ===== */
.main-content {
    margin-left:250px;
    padding:40px;
    width:calc(100% - 250px);
}

/* ===== PAGE TITLE ===== */
.page-title {
    display:flex;
    align-items:center;
    justify-content:space-between;
    margin-bottom:30px;
}
.page-title h2 {
    color:#FFD700;
    margin:0;
}

/* ===== FORM STYLES ===== */
.container-form {
    max-width:600px;
    background: rgba(30,30,30,0.8);
    padding:30px;
    border-radius:20px;
    border:2px solid #FFD700;
    backdrop-filter: blur(10px);
}
.container-form input[type=text], .container-form input[type=file] {
    width:100%;
    padding:12px;
    border-radius:10px;
    border:2px solid #FFD700;
    background:#111;
    color:#fff;
    margin-bottom:15px;
}
.container-form input:focus {
    outline:none;
    border-color:#ffea00;
    box-shadow:0 0 10px rgba(255,215,0,0.5);
}
.container-form button {
    width:100%;
    padding:12px;
    border:none;
    border-radius:10px;
    background: linear-gradient(45deg,#FFD700,#ffea00);
    color:#000;
    font-weight:700;
    cursor:pointer;
}
.container-form button:hover {
    box-shadow:0 5px 20px rgba(255,215,0,0.6);
}
.back-btn {
    background:#111;
    color:#FFD700;
    border:2px solid #FFD700;
}
.back-btn:hover {
    background:#FFD700;
    color:#000;
    border-color:#FFD700;
}
</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp" class="active"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="FeedbackServlet"><i class="fa fa-comment"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <div class="page-title">
        <h2><i class="fa-solid fa-pen-to-square"></i> Edit Salon</h2>
        <a href="dashboard.jsp" class="btn back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <div class="container-form">
        <form method="post" action="EditSalonServlet" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%=salon.getId()%>">
            <input type="text" name="name" value="<%=salon.getName()%>" placeholder="Salon Name" required>
            <input type="text" name="email" value="<%=salon.getEmail()%>" placeholder="Email">
            <input type="text" name="phone" value="<%=salon.getPhone()%>" placeholder="Phone">
            <input type="text" name="address" value="<%=salon.getAddress()%>" placeholder="Address">
            <input type="file" name="image">
            <button type="submit"><i class="fa-solid fa-floppy-disk"></i> Update Salon</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

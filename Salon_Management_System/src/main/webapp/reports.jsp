<%@ page import="java.util.Map" %>
<%
    // Safe null checks
    Integer totalSalons = (Integer) request.getAttribute("totalSalons");
    if(totalSalons == null) totalSalons = 0;

    Integer totalAppointments = (Integer) request.getAttribute("totalAppointments");
    if(totalAppointments == null) totalAppointments = 0;

    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    if(totalRevenue == null) totalRevenue = 0.0;

    Double avgFeedback = (Double) request.getAttribute("avgFeedback");
    if(avgFeedback == null) avgFeedback = 0.0;

    Map<String,Integer> appointmentsPerTherapist = (Map<String,Integer>) request.getAttribute("appointmentsPerTherapist");
    if(appointmentsPerTherapist == null) appointmentsPerTherapist = new java.util.HashMap<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reports | Admin Panel</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
.page-title h2 { color:#FFD700; margin:0; }

/* ===== CARD STYLES ===== */
.card {
    background: rgba(30,30,30,0.8);
    border:2px solid #FFD700;
    border-radius:15px;
    color:#fff;
    transition: all 0.3s ease;
}
.card:hover {
    transform: scale(1.03);
    box-shadow:0 8px 20px rgba(255,215,0,0.4);
}
.card h4 { color:#FFD700; }
</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="FeedbackServlet"><i class="fa fa-comment"></i> Feedback</a>
    <a href="reports.jsp" class="active"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <div class="page-title">
        <h2><i class="fa-solid fa-chart-bar"></i> Reports</h2>
    </div>

    <!-- SUMMARY CARDS -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h4>Total Salons</h4>
                <p><%=totalSalons%></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h4>Total Appointments</h4>
                <p><%=totalAppointments%></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h4>Total Revenue</h4>
                <p>$<%=String.format("%.2f", totalRevenue)%></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h4>Avg Feedback</h4>
                <p><%=String.format("%.1f", avgFeedback)%> / 5</p>
            </div>
        </div>
    </div>

    <!-- APPOINTMENTS PER THERAPIST CHART -->
    <div class="row">
        <div class="col-md-12">
            <div class="card p-3">
                <h4>Appointments Per Therapist</h4>
                <canvas id="therapistChart"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- CHART.JS SCRIPT -->
<script>
const ctx = document.getElementById('therapistChart').getContext('2d');
const chart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [<%
            for(String t : appointmentsPerTherapist.keySet()){
                out.print("'" + t + "',");
            }
        %>],
        datasets: [{
            label: 'Appointments',
            data: [<%
                for(Integer val : appointmentsPerTherapist.values()){
                    out.print(val + ",");
                }
            %>],
            backgroundColor: 'rgba(255, 215, 0, 0.7)',
            borderColor: 'rgba(255, 215, 0, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive:true,
        plugins: { legend:{ labels:{ color:'#fff' } } },
        scales: {
            y: { beginAtZero:true, ticks: { color:'#fff' } },
            x: { ticks: { color:'#fff' } }
        }
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

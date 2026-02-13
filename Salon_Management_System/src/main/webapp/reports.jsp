<%@ page import="java.util.Map" %>
<%
Integer totalSalons = (Integer) request.getAttribute("totalSalons");
if(totalSalons == null) totalSalons = 0;

Integer totalAppointments = (Integer) request.getAttribute("totalAppointments");
if(totalAppointments == null) totalAppointments = 0;

Double totalRevenue = (Double) request.getAttribute("totalRevenue");
if(totalRevenue == null) totalRevenue = 0.0;

Double avgFeedback = (Double) request.getAttribute("avgFeedback");
if(avgFeedback == null) avgFeedback = 0.0;

Map<String,Integer> appointmentsPerTherapist =
(Map<String,Integer>) request.getAttribute("appointmentsPerTherapist");
if(appointmentsPerTherapist == null)
appointmentsPerTherapist = new java.util.HashMap<>();
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background:#000;
    color:#fff;
    display:flex;
    font-family:Poppins;
}

/* SIDEBAR */
.sidebar{
    width:250px;
    height:100vh;
    background:#000;
    border-right:2px solid #ffd700;
    position:fixed;
}
.sidebar h2{
    color:#ffd700;
    text-align:center;
    padding:20px;
}
.sidebar a{
    display:block;
    color:#fff;
    padding:15px 25px;
    text-decoration:none;
}
.sidebar a:hover,
.sidebar a.active{
    background:#ffd700;
    color:#000;
}

/* MAIN */
.main{
    margin-left:250px;
    padding:40px;
    width:100%;
}

/* CARDS */
.card{
    background:#111;
    border:1px solid #ffd700;
    color:#fff;
    text-align:center;
}
.card h4{ color:#ffd700; }
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>Salon Admin</h2>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="AdminTherapistServlet">Therapists</a>
    <a href="AdminAppointmentServlet">Appointments</a>
    <a href="AdminFeedbackServlet">Feedback</a>
    <a href="reports.jsp" class="active">Reports</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">

<h2 style="color:#ffd700;">Reports</h2>

<div class="row mb-4">
    <div class="col-md-3">
        <div class="card p-3">
            <h4>Total Salons</h4>
            <h2><%=totalSalons%></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3">
            <h4>Total Appointments</h4>
            <h2><%=totalAppointments%></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3">
            <h4>Total Revenue</h4>
            <h2>₹<%=totalRevenue%></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3">
            <h4>Avg Rating</h4>
            <h2><%=avgFeedback%></h2>
        </div>
    </div>
</div>

<div class="card p-4">
    <h4>Appointments Per Therapist</h4>
    <canvas id="chart"></canvas>
</div>

</div>

<script>
const ctx = document.getElementById('chart');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [
            <% for(String name:appointmentsPerTherapist.keySet()){ %>
                "<%=name%>",
            <% } %>
        ],
        datasets: [{
            label: 'Appointments',
            data: [
                <% for(Integer val:appointmentsPerTherapist.values()){ %>
                    <%=val%>,
                <% } %>
            ],
            backgroundColor:'#ffd700'
        }]
    },
    options:{
        scales:{
            y:{beginAtZero:true}
        }
    }
});
</script>

</body>
</html>

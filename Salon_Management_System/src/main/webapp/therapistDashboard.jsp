<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Therapist Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body{
            margin:0;
            font-family:'Segoe UI';
            background:#000;
            color:gold;
            display:flex
        }

        .sidebar{
            width:220px;
            height:100vh;
            background:#111;
            border-right:2px solid gold
        }

        .sidebar a{
            display:flex;
            gap:10px;
            padding:15px 20px;
            color:gold;
            text-decoration:none;
            font-weight:bold
        }

        .sidebar a:hover{
            background:gold;
            color:black
        }

        .main{
            flex:1;
            padding:30px
        }

        /* ================= DASHBOARD CARDS ================= */

        .dashboard-grid{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(150px,1fr));
            gap:20px
        }

        .card-dashboard{
            background:#111;
            border:2px solid gold;
            border-radius:20px;
            padding:20px;
            text-align:center;
            cursor:pointer;
            transition:all 0.3s ease;
        }

        /* 🔥 CARD HOVER EFFECT */
        .card-dashboard:hover{
            transform:translateY(-10px) scale(1.05);
            box-shadow:0 15px 30px rgba(255,215,0,0.6);
            background:linear-gradient(135deg,#111,#222);
        }

        .card-dashboard i{
            font-size:28px;
            margin-bottom:6px;
            transition:transform 0.3s ease,color 0.3s ease;
        }

        .card-dashboard:hover i{
            transform:scale(1.2);
            color:#ffd700;
        }

        .card-dashboard h3{
            font-size:28px;
            margin:0;
            transition:text-shadow 0.3s ease;
        }

        .card-dashboard:hover h3{
            text-shadow:0 0 10px gold;
        }

        /* ================= SECTIONS ================= */

        .card-section{
            background:#111;
            border:1px solid gold;
            border-radius:15px;
            padding:20px;
            margin-top:30px
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <a href="TherapistDashboardServlet"><i class="fa fa-home"></i>Dashboard</a>
    <a href="#"><i class="fa fa-calendar-check"></i>Appointments</a>
    <a href="#"><i class="fa fa-clock"></i>Availability</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">

    <h2>Welcome, ${therapistName}</h2>

    <!-- DASHBOARD CARDS -->
    <div class="dashboard-grid">

        <div class="card-dashboard">
            <i class="fa fa-calendar"></i>
            <h3 class="count" data-count="${totalAppointments}">0</h3>
            <p>Total</p>
        </div>

        <div class="card-dashboard">
            <i class="fa fa-calendar-day"></i>
            <h3 class="count" data-count="${todayAppointments}">0</h3>
            <p>Today</p>
        </div>

        <div class="card-dashboard">
            <i class="fa fa-check-circle"></i>
            <h3 class="count" data-count="${completedAppointments}">0</h3>
            <p>Completed</p>
        </div>

        <div class="card-dashboard">
            <i class="fa fa-times-circle"></i>
            <h3 class="count" data-count="${cancelledAppointments}">0</h3>
            <p>Cancelled</p>
        </div>

    </div>

    <!-- APPOINTMENTS TABLE -->
    <div class="card-section">
        <h4>My Appointments</h4>
        <table class="table table-dark table-striped text-center">
            <tr>
                <th>Customer</th>
                <th>Phone</th>
                <th>Date</th>
                <th>Time</th>
                <th>Service</th>
                <th>Status</th>
                <th>Update</th>
            </tr>

            <c:forEach var="a" items="${appointments}">
                <tr>
                    <td>${a.customerName}</td>
                    <td>${a.phone}</td>
                    <td>${a.date}</td>
                    <td>${a.time}</td>
                    <td>${a.service}</td>
                    <td>${a.status}</td>
                    <td>
                        <form action="UpdateStatusServlet" method="post">
                            <input type="hidden" name="id" value="${a.id}">
                            <select name="status" class="form-select">
                                <option>Confirmed</option>
                                <option>Completed</option>
                                <option>Cancelled</option>
                            </select>
                            <button class="btn btn-warning btn-sm w-100 mt-1">
                                Update
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- AVAILABILITY -->
    <div class="card-section">
        <h4>Update Availability</h4>
        <form action="UpdateAvailabilityServlet" method="post" class="row g-3">
            <div class="col-md-4">
                <input type="date" name="date" class="form-control" required>
            </div>
            <div class="col-md-4">
                <input type="time" name="time" class="form-control" required>
            </div>
            <div class="col-md-4">
                <button class="btn btn-warning w-100">Add</button>
            </div>
        </form>
    </div>

</div>

<!-- 🔥 NUMBER COUNT ANIMATION SCRIPT -->
<script>
    const counters = document.querySelectorAll('.count');

    counters.forEach(counter => {
        let target = +counter.getAttribute('data-count');
        let count = 0;
        let speed = Math.max(10, target / 40);

        const updateCount = () => {
            if(count < target){
                count += speed;
                counter.innerText = Math.ceil(count);
                setTimeout(updateCount, 30);
            } else {
                counter.innerText = target;
            }
        };
        updateCount();
    });
</script>


</body>
</html>

<%@ page import="java.util.*, model.Appointment, model.User, dao.AppointmentDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    List<Appointment> appointments = dao.getAppointmentsByUserId(user.getId());

    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("success");
    session.removeAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Appointments</title>

<!-- Bootstrap & FontAwesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ================= GLOBAL ================= */
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#000;
    color:#fff;
}

/* ================= CONTAINER ================= */
.container-fluid{
    display:flex;
    padding:0;
}

/* ================= SIDEBAR (SAME AS DASHBOARD) ================= */
.sidebar{
    width:260px;
    min-height:100vh;
    background:linear-gradient(180deg,#0f0f0f,#1a1a1a);
    border-right:2px solid #ffd700;
    padding:25px 20px;
}

.sidebar-profile{
    text-align:center;
    border-bottom:1px solid #444;
    padding-bottom:15px;
    margin-bottom:20px;
}

.profile-img{
    width:70px;
    height:70px;
    border-radius:50%;
    border:2px solid #ffd700;
}

.sidebar-profile h5{color:#ffd700;margin-top:10px;}
.sidebar-profile p{font-size:0.9rem;color:#fff;}

.sidebar-menu a{
    display:flex;
    align-items:center;
    padding:12px 15px;
    margin:6px 0;
    color:#fff;
    text-decoration:none;
    border-radius:12px;
    font-weight:500;
}

.sidebar-menu a i{
    margin-right:12px;
    font-size:18px;
}

.sidebar-menu a:hover,
.sidebar-menu a.active{
    background:#ffd700;
    color:#000;
    box-shadow:0 0 12px rgba(255,215,0,0.6);
}

/* ================= MAIN ================= */
.main{
    flex:1;
    padding:25px;
}

/* ================= TABLE ================= */
h2{
    color:#ffd700;
    text-align:center;
    margin-bottom:20px;
}

.table-custom{
    width:100%;
    background:#111;
    border-radius:12px;
    overflow:hidden;
    border:1px solid #d4af37;
}

.table-custom th{
    background:#000;
    color:#ffd700;
    padding:12px;
    border-bottom:2px solid #d4af37;
}

.table-custom td{
    padding:12px;
    color:#fff;
    border-bottom:1px solid #333;
}

.table-custom tr:hover{
    background:#1a1a1a;
}

/* ================= MESSAGES ================= */
.msg{
    margin-bottom:12px;
    padding:10px;
    border-radius:8px;
}

.ok{background:#003d2b;color:#3cffb5;}
.err{background:#3d0000;color:#ff7b7b;}

/* ================= BUTTONS ================= */
.btn-action{
    padding:6px 14px;
    border-radius:20px;
    font-weight:600;
    border:none;
}

.cancel{
    background:#900;
    color:#fff;
}

.reschedule{
    background:#ffd700;
    color:#000;
}
</style>
</head>

<body>

<div class="container-fluid">

    <!-- ===== SIDEBAR ===== -->
    <div class="sidebar">
        
        <div class="sidebar-menu">
            <a href="dashboard.jsp">
                <i class="fa fa-chart-line"></i> Dashboard
            </a>
            <a href="search-salons.jsp">
                <i class="fa fa-magnifying-glass"></i> Search Salons
            </a>
            <a href="myAppointments.jsp" class="active">
                <i class="fa fa-calendar"></i> My Appointments
            </a>
            <a href="user-feedback.jsp">
                <i class="fa fa-star"></i> Feedback
            </a>
            <a href="profile.jsp">
                <i class="fa fa-user"></i> Profile
            </a>
            <a href="LogoutServlet">
                <i class="fa fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <!-- ===== MAIN ===== -->
    <div class="main">

        <h2>My Appointments</h2>

        <% if(success != null){ %>
            <div class="msg ok"><%= success %></div>
        <% } %>

        <% if(error != null){ %>
            <div class="msg err"><%= error %></div>
        <% } %>

        <table class="table-custom">
            <tr>
                <th>Salon</th>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <%
            if(appointments.isEmpty()){
            %>
            <tr>
                <td colspan="6" class="text-center">No appointments booked yet.</td>
            </tr>
            <%
            } else {
                for(Appointment ap : appointments){
            %>
            <tr>
                <td><%= ap.getSalonId() %></td>
                <td><%= ap.getServiceName() %></td>
                <td><%= ap.getAppointmentDate() %></td>
                <td><%= ap.getAppointmentTime() %></td>
                <td><%= ap.getStatus() %></td>
                <td>
                <% if(!"Cancelled".equals(ap.getStatus())) { %>
                    <form action="CancelAppointmentServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= ap.getId() %>">
                        <button type="submit" class="btn-action cancel">Cancel</button>
                    </form>

                    <form action="reschedule.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= ap.getId() %>">
                        <button type="submit" class="btn-action reschedule">Reschedule</button>
                    </form>
                <% } else { %>
                    -
                <% } %>
                </td>
            </tr>
            <%
                }
            }
            %>
        </table>

    </div>
</div>

</body>
</html>

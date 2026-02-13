<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Appointment" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Appointments</title>

   <!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
       /* =========================================
   GLOBAL SETTINGS
========================================= */
body{
    margin:0;
    background:linear-gradient(145deg,#000,#0d0d0d);
    font-family:"Times New Roman", Times, serif;
    color:#fff;
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
/* =========================================
   MAIN CONTENT
========================================= */
.main-content{
    margin-left:260px; /* sidebar width */
    padding:50px;
    min-height:100vh;
    animation:fadeIn 0.8s ease;
}

/* Container Box */
.container{
    background:linear-gradient(145deg,#111,#0a0a0a);
    padding:35px;
    border-radius:20px;
    border:1px solid rgba(212,175,55,0.25);
    box-shadow:
        0 0 30px rgba(212,175,55,0.15),
        inset 0 0 15px rgba(212,175,55,0.05);
    animation:slideUp 0.8s ease;
}

/* =========================================
   HEADING STYLE
========================================= */
.container h2{
    color:#ffd700;
    font-size:30px;
    font-weight:bold;
    margin-bottom:35px;
    letter-spacing:1px;
    position:relative;
    display:inline-block;
    animation:glowText 2s infinite alternate;
}

/* Golden underline animation */
.container h2::after{
    content:"";
    position:absolute;
    bottom:-10px;
    left:0;
    width:100%;
    height:3px;
    background:linear-gradient(90deg,#d4af37,#ffd700,#d4af37);
    animation:goldSlide 3s linear infinite;
}

/* =========================================
   TABLE DESIGN
========================================= */
table{
    width:100%;
    border-collapse:collapse;
    border-radius:15px;
    overflow:hidden;
    animation:fadeUp 1s ease;
}

/* Table Header */
table th{
    background:#0b0b0b;
    color:#ffd700;
    padding:16px;
    text-align:left;
    font-size:15px;
    letter-spacing:0.5px;
    border-bottom:1px solid rgba(212,175,55,0.4);
    text-transform:uppercase;
}

/* Table Data */
table td{
    padding:14px;
    font-size:15px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    transition:0.3s ease;
}

/* Alternate rows */
table tr:nth-child(even){
    background:rgba(255,255,255,0.02);
}

/* Row Hover Effect */
table tr{
    transition:all 0.4s ease;
}

table tr:hover{
    background:rgba(212,175,55,0.08);
    transform:scale(1.01);
    box-shadow:inset 0 0 12px rgba(212,175,55,0.3);
}

/* =========================================
   STATUS STYLING (Badge Style)
========================================= */
td.BOOKED,
td.IN_PROGRESS,
td.COMPLETED,
td.CANCELLED{
    font-weight:bold;
    letter-spacing:0.5px;
}

/* Individual Colors */
td.BOOKED{
    color:#ffc107;
}

td.IN_PROGRESS{
    color:#17a2b8;
}

td.COMPLETED{
    color:#28a745;
}

td.CANCELLED{
    color:#dc3545;
}

/* =========================================
   FORM ELEMENTS
========================================= */
select{
    background:#000;
    color:#ffd700;
    border:1px solid #d4af37;
    padding:6px 10px;
    border-radius:10px;
    font-family:"Times New Roman", Times, serif;
    transition:0.3s ease;
}

select:hover{
    box-shadow:0 0 12px rgba(255,215,0,0.6);
}

button{
    background:linear-gradient(145deg,#d4af37,#ffd700);
    border:none;
    padding:7px 16px;
    border-radius:10px;
    font-weight:bold;
    color:#000;
    font-family:"Times New Roman", Times, serif;
    cursor:pointer;
    transition:0.4s ease;
}

/* Button Hover Animation */
button:hover{
    transform:translateY(-3px);
    box-shadow:
        0 0 20px rgba(255,215,0,0.7),
        inset 0 0 8px rgba(255,255,255,0.4);
}

/* Empty Row */
.empty{
    text-align:center;
    padding:25px;
    color:#ffd700;
    font-weight:500;
}

/* =========================================
   ANIMATIONS
========================================= */

/* Fade Page */
@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

/* Slide Up Container */
@keyframes slideUp{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* Fade Table */
@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* Heading Glow */
@keyframes glowText{
    from{
        text-shadow:0 0 5px #d4af37;
    }
    to{
        text-shadow:0 0 20px #ffd700;
    }
}

/* Golden underline animation */
@keyframes goldSlide{
    0%{background-position:0%;}
    100%{background-position:200%;}
}

    </style>
</head>

<body>

    <div class="sidebar">
    <h2><i class="fa fa-gem"></i>GoldenGlow Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"class="active"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="admin-feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="container">
            <h2>All Appointments</h2>

            <table>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>

                <%
                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");

                if(appointments == null || appointments.isEmpty()){
                %>
                <tr>
                    <td colspan="7" class="empty">No appointments found</td>
                </tr>
                <%
                }else{
                    for(Appointment a : appointments){
                %>
                <tr>
                    <td><%= a.getId() %></td>
                    <td><%= a.getUserId() %></td>
                    <td><%= a.getServiceName() %></td>
                    <td><%= a.getAppointmentDate() %></td>
                    <td><%= a.getAppointmentTime() %></td>

                    <td class="<%= a.getStatus() %>"><%= a.getStatus() %></td>

                    <td>
                        <form method="post" action="AdminAppointmentServlet" style="display:flex; gap:5px;">
                            <input type="hidden" name="appointmentId" value="<%= a.getId() %>">
                            <select name="status">
                                <option value="BOOKED" <%= "BOOKED".equals(a.getStatus())?"selected":"" %>>BOOKED</option>
                                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(a.getStatus())?"selected":"" %>>IN PROGRESS</option>
                                <option value="COMPLETED" <%= "COMPLETED".equals(a.getStatus())?"selected":"" %>>COMPLETED</option>
                                <option value="CANCELLED" <%= "CANCELLED".equals(a.getStatus())?"selected":"" %>>CANCELLED</option>
                            </select>
                            <button type="submit"><i class="bi bi-save"></i> Update</button>
                        </form>
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

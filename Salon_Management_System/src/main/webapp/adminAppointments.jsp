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
        body{
            font-family: 'Poppins', sans-serif;
            margin:0;
            background:#0f0f0f;
            color:#fff;
            display:flex;
        }

/* ===== SIDEBAR ===== */
.sidebar { width:250px; background:#000; min-height:100vh; position:fixed; border-right:2px solid #FFD700; padding-top:10px; }
.sidebar h2 { text-align:center; padding:20px; color:#FFD700; font-weight:600; border-bottom:1px solid #222; font-size:1.3rem; }
.sidebar a { display:flex; align-items:center; color:#fff; padding:14px 22px; text-decoration:none; border-bottom:1px solid #111; font-weight:500; font-size:19px; }
.sidebar a i { margin-right:12px; font-size:1.1rem; }
.sidebar a:hover, .sidebar a.active { background:#FFD700; color:#000; padding-left:28px; }

        /* CONTENT */
        .main-content{
            margin-left:250px; /* Sidebar width */
            padding:30px;
            width:100%;
        }

        .container{
            width:100%;
            max-width:1200px;
            background:#151515;
            padding:25px;
            border-radius:10px;
            box-shadow:0 0 15px rgba(212,175,55,0.3);
        }

        h2{
            margin-bottom:20px;
            color:#FFD700;
        }

        table{
            width:100%;
            border-collapse:collapse;
            margin-top:20px;
            background:#1f1f1f;
        }

        th{
            background:#FFD700;
            color:#000;
            padding:12px;
            text-align:left;
        }

        td{
            padding:12px;
            border-bottom:1px solid #333;
        }

        tr:hover{
            background: rgba(212,175,55,0.1);
        }

        select{
            padding:6px;
            border-radius:6px;
            border:1px solid #333;
            background:#000;
            color:#fff;
        }

        button{
            padding:6px 12px;
            background:linear-gradient(45deg,#FFD700,#ffb300);
            color:#000;
            border:none;
            border-radius:6px;
            cursor:pointer;
            font-weight:600;
        }

        button:hover{
            background:linear-gradient(45deg,#ffb300,#FFD700);
        }

        .BOOKED{ color:#007bff; font-weight:bold; }
        .IN_PROGRESS{ color:#ff9800; font-weight:bold; }
        .COMPLETED{ color:green; font-weight:bold; }
        .CANCELLED{ color:red; font-weight:bold; }

        .empty{
            text-align:center;
            padding:20px;
            color:#aaa;
        }
    </style>
</head>

<body>

    <div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"class="active"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
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

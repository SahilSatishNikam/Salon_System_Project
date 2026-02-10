<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Appointment" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Appointments</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body{
            font-family: 'Poppins', sans-serif;
            margin:0;
            background:#0f0f0f;
            color:#fff;
            display:flex;
        }

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

    <!-- INCLUDE SIDEBAR -->
    <jsp:include page="sidebar.jsp" />

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

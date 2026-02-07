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
<html>
<head>
    <title>My Appointments</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            font-family:Arial, sans-serif;
            background:#000;
            padding:20px;
        }

        h2{
            text-align:center;
            margin-bottom:20px;
            color:#ffd700; /* golden heading */
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:#111;
            border-radius:12px;
            overflow:hidden;
        }

        /* ⭐ GOLDEN TABLE HEADINGS ⭐ */
        th{
            background:#000;
            color:#ffd700;          /* golden color */
            padding:12px;
            font-weight:bold;
            border-bottom:2px solid #d4af37;
        }

        td{
            padding:12px;
            color:#fff;
            border-bottom:1px solid #333;
        }

        tr:hover{
            background:#1a1a1a;
        }

        .msg{
            margin-bottom:12px;
            padding:10px;
            border-radius:8px;
        }

        .ok{
            background:#003d2b;
            color:#3cffb5;
        }

        .err{
            background:#3d0000;
            color:#ff7b7b;
        }

        .btn{
            padding:6px 12px;
            border-radius:20px;
            font-weight:600;
        }

        .cancel{
            background:#900;
            color:#fff;
            border:none;
        }

        .reschedule{
            background:#ffd700;
            color:#000;
            border:none;
        }
    </style>
</head>

<body>

<h2>My Appointments</h2>

<% if(success != null){ %>
    <div class="msg ok"><%= success %></div>
<% } %>

<% if(error != null){ %>
    <div class="msg err"><%= error %></div>
<% } %>

<table>
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
        <td colspan="6" style="text-align:center;">No appointments booked yet.</td>
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
                <button type="submit" class="btn cancel">Cancel</button>
            </form>

            <form action="reschedule.jsp" method="get" style="display:inline;">
                <input type="hidden" name="id" value="<%= ap.getId() %>">
                <button type="submit" class="btn reschedule">Reschedule</button>
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

</body>
</html>

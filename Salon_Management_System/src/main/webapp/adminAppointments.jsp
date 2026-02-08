<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Appointment" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Appointments</title>

    <style>
        body{
            font-family: Arial, Helvetica, sans-serif;
            background:#f4f6f9;
            margin:0;
            padding:0;
        }

        .container{
            width:95%;
            max-width:1200px;
            margin:40px auto;
            background:#fff;
            padding:25px;
            border-radius:10px;
            box-shadow:0 0 15px rgba(0,0,0,0.08);
        }

        h2{
            margin-bottom:20px;
            color:#333;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th{
            background:#343a40;
            color:white;
            padding:12px;
            text-align:left;
        }

        td{
            padding:12px;
            border-bottom:1px solid #ddd;
        }

        tr:hover{
            background:#f1f1f1;
        }

        select{
            padding:6px;
            border-radius:6px;
            border:1px solid #ccc;
        }

        button{
            padding:6px 12px;
            background:#007bff;
            color:white;
            border:none;
            border-radius:6px;
            cursor:pointer;
        }

        button:hover{
            background:#0056b3;
        }

        .BOOKED{ color:#007bff; font-weight:bold; }
        .IN_PROGRESS{ color:#ff9800; font-weight:bold; }
        .COMPLETED{ color:green; font-weight:bold; }
        .CANCELLED{ color:red; font-weight:bold; }

        .empty{
            text-align:center;
            padding:20px;
            color:#777;
        }
    </style>
</head>

<body>

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

    <td class="<%= a.getStatus() %>">
        <%= a.getStatus() %>
    </td>

    <td>
        <form method="post" action="AdminAppointmentServlet" style="display:flex; gap:5px;">
            <input type="hidden" name="appointmentId" value="<%= a.getId() %>">

            <select name="status">
                <option value="BOOKED" <%= "BOOKED".equals(a.getStatus())?"selected":"" %>>BOOKED</option>
                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(a.getStatus())?"selected":"" %>>IN PROGRESS</option>
                <option value="COMPLETED" <%= "COMPLETED".equals(a.getStatus())?"selected":"" %>>COMPLETED</option>
                <option value="CANCELLED" <%= "CANCELLED".equals(a.getStatus())?"selected":"" %>>CANCELLED</option>
            </select>

            <button type="submit">Update</button>
        </form>
    </td>
</tr>
<%
    }
}
%>

    </table>
</div>

</body>
</html>

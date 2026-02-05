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
    <style>
        body { font-family: Arial, sans-serif; background:#f7f8fc; padding:20px; }
        h2 { text-align:center; margin-bottom:20px; }
        table {
            width:100%; border-collapse: collapse;
            background:#fff; border-radius:16px; overflow:hidden;
            box-shadow:0 10px 22px rgba(0,0,0,.1);
        }
        th, td { padding:12px; text-align:left; border-bottom:1px solid #eee; }
        th { background:#f1f3f8; font-weight:600; }
        tr:last-child td { border-bottom:none; }
        .btn {
            padding:6px 12px; border:none; border-radius:6px;
            cursor:pointer; font-weight:600;
        }
        .cancel { background:#e74c3c; color:#fff; }
        .reschedule { background:#3498db; color:#fff; }
        .msg { margin-bottom:12px; padding:10px; border-radius:8px; }
        .ok { background:#e0ffe6; color:#0a7a3c; }
        .err { background:#ffe0e0; color:#900; }
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
        <tr><td colspan="6" style="text-align:center;">No appointments booked yet.</td></tr>
    <%
        } else {
            for(Appointment ap : appointments){
    %>
    <tr>
        <td><%= ap.getSalonId() %></td> <!-- You can replace with SalonDAO.getSalonById(ap.getSalonId()).getName() for name -->
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
                <form action="RescheduleAppointmentServlet" method="get" style="display:inline;">
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
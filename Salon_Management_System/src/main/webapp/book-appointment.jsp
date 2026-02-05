
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service, model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f7f8fc; padding:20px; }
        .container { max-width:600px; margin:auto; }
        .card {
            background:#fff; padding:20px;
            border-radius:16px; box-shadow:0 10px 22px rgba(0,0,0,.1);
        }
        h2 { margin-top:0; }
        .info { background:#f1f3f8; padding:12px; border-radius:10px; margin-bottom:14px; }
        label { font-weight:600; display:block; margin-top:12px; }
        input, select {
            width:100%; padding:10px; margin-top:6px;
            border-radius:8px; border:1px solid #ddd;
        }
        button {
            width:100%; margin-top:16px; padding:12px;
            background:#111; color:#fff; border:none;
            border-radius:10px; font-weight:600; cursor:pointer;
        }
        .msg { margin-bottom:12px; padding:10px; border-radius:8px; }
        .err { background:#ffe0e0; color:#900; }
        .ok { background:#e0ffe6; color:#0a7a3c; }
        .back { display:inline-block; margin-bottom:12px; text-decoration:none; }
    </style>
</head>
<body>
<div class="container">

    <a class="back" href="javascript:history.back()">← Back</a>

    <div class="card">
        <h2>Book Appointment</h2>

        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String salonIdStr = request.getParameter("salonId");
            String serviceIdStr = request.getParameter("serviceId");

            int salonId = 0, serviceId = 0;
            try {
                salonId = Integer.parseInt(salonIdStr);
                serviceId = Integer.parseInt(serviceIdStr);
            } catch(Exception e) {}

            Salon salon = null;
            Service service = null;

            try {
                salon = new SalonDAO().getSalonById(salonId);
                service = new ServiceDAO().getServiceById(serviceId);
            } catch(Exception e) { e.printStackTrace(); }

            if (salon == null || service == null) {
        %>
            <div class="msg err">Invalid salon or service selected.</div>
        <%
                return;
            }

            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="msg err"><%= error %></div>
        <% } %>
        <% if (success != null) { %>
            <div class="msg ok"><%= success %></div>
        <% } %>

        <div class="info">
            <b>Salon:</b> <%= salon.getName() %> <br>
            <b>Service:</b> <%= service.getName() %> <br>
            <b>Price:</b> ₹ <%= service.getPrice() %> <br>
            <b>Duration:</b> <%= service.getDurationMinutes() %> mins
        </div>

        <form action="<%= request.getContextPath() %>/BookAppointmentServlet" method="post">
            <input type="hidden" name="salonId" value="<%= salonId %>">
            <input type="hidden" name="serviceName" value="<%= service.getName() %>">

            <label>Select Date</label>
            <input type="date" name="date" required min="<%= java.time.LocalDate.now() %>">

            <label>Select Time</label>
            <input type="time" name="time" required>

            <button type="submit">Confirm Booking</button>
        </form>
    </div>

</div>
</body>
</html>





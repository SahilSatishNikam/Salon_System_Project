<%@ page contentType="text/html;charset=UTF-8" %>
<%
model.Therapist t = (model.Therapist) session.getAttribute("therapist");
if(t == null){ response.sendRedirect("login.jsp"); return; }
%>

<!DOCTYPE html>
<html>
<head>
<title>Set Availability</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
/* ===== General ===== */
body {
    background: #121212;
    font-family: 'Poppins', sans-serif;
    color: #E0E0E0;
    overflow-x: hidden;
}

/* ===== Sidebar ===== */
/* ===== Sidebar ===== */
.sidebar {
    height: 100vh;
    background: #1B1B1B;
    border-right: 2px solid #FFD700;
    padding-top: 30px;
    position: fixed;
    width: 220px;
    transition: all 0.3s ease;
}
.sidebar h3 {
    color: #FFD700;
    text-align: center;
    margin-bottom: 40px;
    font-weight: 800;
}
.sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #E0E0E0;
    padding: 12px 20px;
    margin-bottom: 10px;
    border-radius: 8px;
    transition: all 0.3s ease;
    text-decoration:none;
}
.sidebar a:hover, .sidebar a.active {
    background: #FFD700;
    color: #1B1B1B;
    transform: translateX(5px);
    width:200px;
    
}
.sidebar a i {
    transition: 0.3s ease;
}

/* ===== Main Content ===== */
.main-content {
    margin-left: 220px;
    padding: 40px 50px;
}

/* ===== Header ===== */
.main-content h1 {
    color: #FFF;
    font-weight: 700;
    font-size: 2rem;
    margin-bottom: 5px;
    text-align:center;
}
.main-content p {
    color: #BBB;
    font-size: 0.95rem;
    margin-bottom: 30px;
    text-align:center;
}

/* ===== Form Card ===== */
.form-card {
    background: #1E1E1E;
    padding: 30px 35px;
    border-radius: 12px;
    max-width: 600px;
    margin: 0 auto;
    box-shadow: 0 4px 20px rgba(0,0,0,0.5);
}
.form-card h2 {
    color: #FFD700;
    font-weight: 700;
    margin-bottom: 20px;
}
.form-card label {
    display: block;
    font-weight: 600;
    margin-bottom: 5px;
    font-size: 0.9rem;
}
.form-card input {
    width: 100%;
    padding: 12px 15px;
    margin-bottom: 20px;
    border-radius: 8px;
    border: 1px solid #333;
    background: #1B1B1B;
    color: #E0E0E0;
    transition: all 0.3s ease;
}
.form-card input:focus {
    border-color: #FFD700;
    box-shadow: 0 0 10px rgba(255,215,0,0.3);
    outline: none;
}

/* ===== Save Button ===== */
.form-card button {
    width: 100%;
    padding: 15px;
    background: #FFD700;
    color: #1B1B1B;
    font-weight: 700;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    text-transform: uppercase;
    transition: 0.3s ease;
}
.form-card button:hover {
    background: #FFC107;
    transform: scale(1.05);
}

/* ===== Toggle Switches ===== */
.toggle-group {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
}
.toggle-group label {
    font-weight: 500;
    font-size: 0.9rem;
}
.toggle-switch {
    position: relative;
    display: inline-block;
    width: 40px;
    height: 20px;
}
.toggle-switch input { display: none; }
.slider {
    position: absolute;
    cursor: pointer;
    background-color: #555;
    border-radius: 20px;
    top: 0; left: 0;
    right: 0; bottom: 0;
    transition: .4s;
}
.slider:before {
    position: absolute;
    content: "";
    height: 16px;
    width: 16px;
    left: 2px;
    bottom: 2px;
    background-color: #FFF;
    transition: .4s;
    border-radius: 50%;
}
input:checked + .slider {
    background-color: #FFD700;
}
input:checked + .slider:before {
    transform: translateX(20px);
}

/* ===== Info Box ===== */
.info-box {
    margin-top: 20px;
    padding: 12px 15px;
    background: #1B1B1B;
    border-left: 4px solid #00A6FF;
    color: #BBB;
    border-radius: 6px;
    font-size: 0.9rem;
}

/* ===== Responsive ===== */
@media(max-width:768px){
    .main-content{ margin-left:0; padding:20px; }
    .sidebar{ position: relative; width:100%; height:auto; border-right:none;}
}
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3><i class="fa-solid fa-hand-sparkles"></i> Therapist</h3>
    <a href="therapistDashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="therapistAvailability.jsp" class="active"><i class="fa-solid fa-clock"></i> Set Availability</a>
    <a href="TherapistAppointmentServlet"><i class="fa-solid fa-calendar-check"></i> Appointments</a>
    <a href="logoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h1>Schedule Management</h1>
    <p>Configure your clinical hours and consultation slots for new and existing clients.</p>

    <div class="form-card">
        <h2><i class="fa-solid fa-clock"></i> Set Your Availability</h2>

        <form action="AddAvailabilityServlet" method="post">
            <input type="hidden" name="therapistId" value="<%= t.getId() %>">
            
            <label for="date">Select Date</label>
            <input type="date" id="date" name="date" required>
            
            <label for="start">Start Time</label>
            <input type="time" id="start" name="start" required>
            
            <label for="end">End Time</label>
            <input type="time" id="end" name="end" required>
            
            <label for="duration">Slot Duration</label>
            <input type="number" id="duration" name="duration" value="60" required>
            
            <!-- Example toggles for future features -->
            <div class="toggle-group">
                <label>Allow Waitlist</label>
                <label class="toggle-switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>

                <label>Virtual Only</label>
                <label class="toggle-switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>
            </div>

            <button type="submit"><i class="fa-solid fa-check"></i> Save Availability</button>
        </form>

        <div class="info-box">
            <strong>Pro Tip:</strong> You can set recurring availability patterns in the "Settings" tab to automate your weekly schedule.
        </div>
    </div>
</div>

</body>
</html>

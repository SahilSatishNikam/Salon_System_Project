<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Salons</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>

/* ===== GLOBAL ===== */
body{
    background:#0f0f0f;
    font-size:18px;
    color:#c9a227;
    font-family:"Times New Roman", serif;
}

/* ===== CONTENT SHIFT (FOR SIDEBAR) ===== */
.content{
    margin-left:260px;
    padding:40px;
}

/* ===== FORM ===== */
.form-row{
    display:flex;
    gap:20px;
}

.form-row input{
    flex:1;
    background:white;
    border-radius:16px;
    padding:16px;
    border:none;
    font-size:18px;
}

/* ===== UPLOAD BOX (GLASS EFFECT) ===== */
.upload-box{
    border:2px dashed #c9a227;
    border-radius:20px;
    height:180px;
    margin-top:20px;

    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;

    cursor:pointer;

    background:rgba(255,255,255,0.04);
    backdrop-filter:blur(8px);
    transition:0.3s;
}

.upload-box:hover{
    background:rgba(201,162,39,0.08);
    transform:scale(1.01);
}

.upload-box i{
    font-size:28px;
    color:#c9a227;
}

.upload-box span{
    color:#c9a227;
    margin-top:8px;
}

.upload-box input{
    display:none;
}

/* ===== ADD BUTTON ===== */
.add-row{
    display:flex;
    justify-content:flex-end;
    margin-top:14px;
}

.add-btn{
    background:#b89632;
    color:black;
    border-radius:14px;
    padding:12px 28px;
    border:none;
    font-size:18px;
    transition:0.3s;
}

.add-btn:hover{
    box-shadow:0 0 14px #c9a227;
    transform:translateY(-2px);
}

/* ===== SALON LIST CARDS ===== */
table{
    background:#161616;
    border-radius:20px;
    margin-top:18px;
    font-size:18px;
    width:100%;

    border:1px solid rgba(201,162,39,0.2);
    transition:0.3s;
}

table:hover{
    box-shadow:0 0 14px rgba(201,162,39,0.2);
}

td{
    border:none;
    padding:18px;
}

img{
    border-radius:50%;
    border:2px solid #c9a227;
}

/* ICON ACTIONS */
.bi-pencil{
    color:#c9a227;
    margin-right:10px;
}

.bi-trash{
    color:#ff5c5c;
}

</style>

<script>
function chooseFile(){
    document.getElementById("fileInput").click();
}
</script>

</head>

<body>

<!-- ===== USE YOUR SIDEBAR FILE ===== -->
<%@ include file="sidebar.jsp" %>

<!-- ===== MAIN CONTENT ===== -->
<div class="content">

<h2 style="margin-bottom:20px;">Add New Salon</h2>

<form method="post" action="AddSalonServlet" enctype="multipart/form-data">

<div class="form-row">
<input type="text" name="name" placeholder="Salon Name" required>
<input type="text" name="email" placeholder="Email">
<input type="text" name="phone" placeholder="Phone">
<input type="text" name="address" placeholder="Address">
</div>

<div class="upload-box" onclick="chooseFile()">
    <i class="bi bi-cloud-arrow-up"></i>
    <span>Click to upload salon thumbnail</span>
    <input id="fileInput" type="file" name="image" required>
</div>

<div class="add-row">
<button class="add-btn" type="submit">+ ADD SALON</button>
</div>

</form>

<h2 style="margin-top:30px;">All Salons</h2>

<%
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();
List<Salon> salons = salonDAO.getAllSalons();

for (Salon s : salons) {
    s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<table>
<tr>

<td width="120">
<% if (s.getImage() != null) { %>
<img src="SalonImageServlet?id=<%= s.getId() %>" width="90" height="90">
<% } %>
</td>

<td>
<b style="font-size:19px;color:#c9a227"><%= s.getName() %></b><br>
<%= s.getEmail() %> | <%= s.getPhone() %>
</td>

<td>
<%= s.getAddress() %>
</td>

<td width="120">

<a href="EditSalonServlet?id=<%= s.getId() %>">
    <i class="bi bi-pencil"></i>
</a>

<a href="DeleteSalonServlet?id=<%= s.getId() %>"
onclick="return confirm('Delete this salon?')">
    <i class="bi bi-trash"></i>
</a>

</td>

</tr>
</table>

<% } %>

</div>

</body>
</html>

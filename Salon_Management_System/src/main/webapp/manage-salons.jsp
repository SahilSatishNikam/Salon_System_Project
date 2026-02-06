<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<html>
<head>
<title>Manage Salons & Services</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#0f0f0f;
    color:#fff;
    margin:0;
    padding:30px;
}

/* headings */
h2{
    color:#FFD700;
    border-bottom:2px solid #FFD700;
    padding-bottom:5px;
}

/* card */
.card{
    background:#1a1a1a;
    padding:20px;
    border-radius:12px;
    margin-bottom:25px;
    box-shadow:0 0 10px rgba(255,215,0,0.15);
}

/* form */
input,button{
    padding:10px;
    border-radius:6px;
    border:none;
    margin:5px;
}

input{
    background:#000;
    color:#fff;
    border:1px solid #FFD700;
}

button{
    background:#FFD700;
    color:#000;
    font-weight:600;
    cursor:pointer;
}

button:hover{
    background:#e6c200;
}

/* tables */
table{
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
    background:#111;
    border-radius:10px;
    overflow:hidden;
}

th{
    background:#FFD700;
    color:#000;
    padding:12px;
}

td{
    padding:12px;
    border-bottom:1px solid #333;
}

tr:hover{
    background:#1c1c1c;
}

img{
    border-radius:8px;
}

/* links */
a{
    color:#FFD700;
    text-decoration:none;
    font-weight:500;
}

a:hover{
    text-decoration:underline;
}

/* service box */
.service-box{
    background:#000;
    padding:15px;
    border-radius:10px;
    margin-top:10px;
    border:1px solid #FFD700;
}

/* buttons */
.btn{
    padding:6px 12px;
    border-radius:6px;
    margin-right:5px;
}

.edit{background:#fff;color:#000;}
.delete{background:#ff4d4d;color:#fff;}
.manage{background:#FFD700;color:#000;}
</style>

<script>
function toggleServiceForm(id){
    const form=document.getElementById('serviceForm-'+id);
    form.style.display=form.style.display==='none'?'block':'none';
}
</script>
</head>

<body>

<div class="card">
<h2>✨ Add New Salon</h2>

<form method="post" action="AddSalonServlet" enctype="multipart/form-data">
<input type="text" name="name" placeholder="Salon Name" required>
<input type="text" name="email" placeholder="Email">
<input type="text" name="phone" placeholder="Phone">
<input type="text" name="address" placeholder="Address">
<input type="file" name="image" required>
<button>Add Salon</button>
</form>
</div>

<h2>🏢 All Salons</h2>

<%
SalonDAO salonDAO=new SalonDAO();
ServiceDAO serviceDAO=new ServiceDAO();
List<Salon> salons=salonDAO.getAllSalons();

for(Salon s:salons){
s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<div class="card">

<table>
<tr>

<td style="width:90px;">
<% if(s.getImage()!=null){ %>
<img src="SalonImageServlet?id=<%=s.getId()%>" width="80" height="80">
<% } else { %>No Image<% } %>
</td>

<td>
<b style="color:#FFD700;"><%=s.getName()%></b><br>
<small><%=s.getEmail()%></small><br>
<small><%=s.getPhone()%></small><br>
<small><%=s.getAddress()%></small>
</td>

<td>
<a class="btn edit" href="EditSalonServlet?id=<%=s.getId()%>">Edit</a>
<a class="btn delete" href="DeleteSalonServlet?id=<%=s.getId()%>" onclick="return confirm('Delete salon?')">Delete</a>
<button class="btn manage" onclick="toggleServiceForm(<%=s.getId()%>)">Services</button>
</td>

</tr>
</table>

<div id="serviceForm-<%=s.getId()%>" style="display:none">

<div class="service-box">
<h3 style="color:#FFD700;">Services - <%=s.getName()%></h3>

<form method="post" action="AddServiceServlet">
<input type="hidden" name="salonId" value="<%=s.getId()%>">
<input type="text" name="name" placeholder="Service Name" required>
<input type="text" name="description" placeholder="Description">
<input type="number" name="price" placeholder="Price" required>
<input type="number" name="durationMinutes" placeholder="Duration" required>
<button>Add Service</button>
</form>

<table>
<tr>
<th>Name</th>
<th>Description</th>
<th>Price</th>
<th>Duration</th>
<th>Action</th>
</tr>

<% if(s.getServices()!=null && !s.getServices().isEmpty()){
for(Service srv:s.getServices()){ %>

<tr>
<td><%=srv.getName()%></td>
<td><%=srv.getDescription()%></td>
<td>₹<%=srv.getPrice()%></td>
<td><%=srv.getDurationMinutes()%> min</td>
<td>
<a class="btn edit" href="EditServiceServlet?id=<%=srv.getId()%>">Edit</a>
<a class="btn delete" href="DeleteServiceServlet?id=<%=srv.getId()%>&salonId=<%=s.getId()%>">Delete</a>
</td>
</tr>

<% }} else { %>
<tr><td colspan="5">No services yet</td></tr>
<% } %>

</table>
</div>
</div>

</div>
<% } %>

</body>
</html>

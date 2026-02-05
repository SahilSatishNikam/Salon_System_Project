
<%@ page import="java.util.*,dao.*,model.*" %>

<%
List<Feedback> list=
new FeedbackDAO().getAll();
%>

<div class="container mt-4">

<h4>Feedback</h4>

<table class="table">

<tr class="table-dark">
<th>User</th>
<th>Message</th>
<th>Rating</th>
</tr>

<% for(Feedback f:list){ %>

<tr>
<td><%=f.getUser()%></td>
<td><%=f.getMessage()%></td>
<td><%=f.getRating()%>/5</td>
</tr>

<% } %>

</table>
</div>



















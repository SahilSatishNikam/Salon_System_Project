<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User, model.Feedback, dao.FeedbackDAO" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = request.getParameter("message");
    String ratingParam = request.getParameter("rating");
    String successMsg = null;

    if(message != null && ratingParam != null) {
        int rating = Integer.parseInt(ratingParam);

        Feedback f = new Feedback();
        f.setUser(user.getName());
        f.setMessage(message);
        f.setRating(rating);

        FeedbackDAO dao = new FeedbackDAO();
        if(dao.saveFeedback(f)) {
            successMsg = "Thank you! Your feedback has been submitted.";
        } else {
            successMsg = "Oops! Something went wrong.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { font-family: Arial; background: #fff8e1; padding: 20px; }
        h1 { color: #ffb300; margin-bottom: 20px; }
        .feedback-form { max-width: 600px; margin:auto; background:#fff; border:1px solid #000; border-radius:12px; padding:25px; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
        .rating-stars i { font-size:24px; color:#ffb300; cursor:pointer; }
        .success-msg { text-align:center; color:green; margin-bottom:15px; font-weight:bold; }
        textarea { resize:none; }
    </style>
    <script>
        function setRating(r) {
            document.getElementById('rating').value = r;
            const stars = document.querySelectorAll('.rating-stars i');
            stars.forEach((s, idx) => {
                if(idx < r) { s.classList.add('fa-solid'); s.classList.remove('fa-regular'); }
                else { s.classList.remove('fa-solid'); s.classList.add('fa-regular'); }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h1><i class="fa-solid fa-comment-dots"></i> Submit Feedback</h1>
    <% if(successMsg != null) { %>
        <div class="success-msg"><%= successMsg %></div>
    <% } %>
    <div class="feedback-form">
        <form method="post">
            <div class="mb-3">
                <label>Your Feedback</label>
                <textarea name="message" class="form-control" rows="5" required placeholder="Write your feedback..."></textarea>
            </div>
            <div class="mb-3">
                <label>Rating</label>
                <div class="rating-stars">
                    <i class="fa-regular fa-star" onclick="setRating(1)"></i>
                    <i class="fa-regular fa-star" onclick="setRating(2)"></i>
                    <i class="fa-regular fa-star" onclick="setRating(3)"></i>
                    <i class="fa-regular fa-star" onclick="setRating(4)"></i>
                    <i class="fa-regular fa-star" onclick="setRating(5)"></i>
                </div>
                <input type="hidden" id="rating" name="rating" value="0" required>
            </div>
            <button type="submit" class="btn btn-dark"><i class="fa-solid fa-paper-plane"></i> Submit</button>
        </form>
    </div>
</div>
</body>
</html>

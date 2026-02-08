<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<style>
.luxury-footer{
    background:linear-gradient(180deg,#000,#0b0b0b);
    color:#e6e6e6;
    padding:60px 8% 20px;
    font-family:'Poppins',sans-serif;
}

.footer-container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:40px;
}

/* Titles */
.footer-box h3{
    color:#d4af37;
    font-size:20px;
    margin-bottom:18px;
    position:relative;
}

.footer-box h3::after{
    content:'';
    width:40px;
    height:2px;
    background:#d4af37;
    position:absolute;
    left:0;
    bottom:-6px;
}

/* Text */
.footer-box p{
    line-height:1.8;
    font-size:14px;
    color:#cfcfcf;
}

/* Links */
.footer-box ul{
    list-style:none;
    padding:0;
}

.footer-box ul li{
    margin-bottom:10px;
}

.footer-box ul li a{
    color:#cfcfcf;
    text-decoration:none;
    transition:.3s;
}

.footer-box ul li a:hover{
    color:#d4af37;
    padding-left:5px;
}

/* Icons */
.footer-box i{
    color:#d4af37;
    margin-right:8px;
}

.footer-social {
    margin-top: 15px;
}

.footer-social a {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 42px;
    height: 42px;
    margin-right: 10px;
    border-radius: 50%;
    background: #111;
    color: #d4af37; /* gold */
    font-size: 18px;
    transition: all 0.3s ease;
    border: 1px solid #d4af37;
    text-decoration: none;
}

.footer-social a:hover {
    background: #d4af37;
    color: #000;
    transform: translateY(-4px);
}

/* Bottom */
.footer-bottom{
    margin-top:30px;
    padding-top:15px;
    border-top:1px solid rgba(212,175,55,.3);
    text-align:center;
    font-size:14px;
    color:#aaa;
}

.footer-bottom span{
    color:#d4af37;
}

</style>
</head>
<body>
<!-- FOOTER -->
<footer class="luxury-footer">
    <div class="footer-container">

        <!-- About -->
        <div class="footer-box">
            <h3>Royal Thai Salon</h3>
            <p>
                Experience elegance, relaxation, and beauty inspired by
                Thailand’s royal spa culture.
            </p>
        </div>

        <!-- Quick Links -->
        <div class="footer-box">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="appointment.jsp">Book Appointment</a></li>
            </ul>
        </div>

        <!-- Contact -->
        <div class="footer-box">
            <h3>Contact Us</h3>
            <p><i class="fa-solid fa-location-dot"></i> Pune, India</p>
            <p><i class="fa-solid fa-envelope"></i> royal@salon.com</p>
            <p><i class="fa-solid fa-phone"></i> +91 99999 88888</p>

            <div class="footer-social">
    <a href="https://www.instagram.com/yourpage" target="_blank" title="Instagram">
        <i class="fab fa-instagram"></i>
    </a>
    <a href="https://www.facebook.com/yourpage" target="_blank" title="Facebook">
        <i class="fab fa-facebook-f"></i>
    </a>
    <a href="https://wa.me/919999988888" target="_blank" title="WhatsApp">
        <i class="fab fa-whatsapp"></i>
    </a>
</div>

        </div>

    </div>

    <div class="footer-bottom">
        © 2026 GoldenGlow Salon Management System | Designed for Luxury <span>❤</span>
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="header.jsp" %>

<style>

/* ===== GLOBAL ===== */
body{
    margin:0;
    padding:0;
    background:#000;
    color:#e6d8a8;
    font-family:'Playfair Display', serif;
}

/* ===== SECTION WITH BACKGROUND IMAGE ===== */
.section-dark{
    background:
        linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.95)),
        url("images/philo.jpg") center/cover no-repeat;

    padding:120px 15% 80px 15%;   /* top space for fixed navbar */
    text-align:center;
}

/* ===== TITLE ===== */
.section-title{
    font-size:48px;
    color:#d4af37;
    margin-bottom:15px;
    text-shadow:0 0 25px rgba(212,175,55,0.8);
}

.section-subtitle{
    font-size:18px;
    color:#f5e6b0;
    margin-bottom:60px;
}

/* ===== CONTACT GRID ===== */
.contact-container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:50px;
}

/* ===== CONTACT BOX ===== */
.contact-box{
    background:rgba(0,0,0,0.85);
    border:1px solid #d4af37;
    border-radius:18px;
    padding:35px;
    box-shadow:0 0 30px rgba(212,175,55,0.3);
    backdrop-filter:blur(6px);
    transition:0.4s ease;
}

.contact-box:hover{
    box-shadow:0 0 60px rgba(212,175,55,0.9);
    transform:translateY(-8px);
}

/* ===== FORM ===== */
.contact-box label{
    color:#d4af37;
    display:block;
    margin-bottom:6px;
    text-align:left;
}

.contact-box input,
.contact-box textarea{
    width:100%;
    background:#111;
    border:1px solid #333;
    color:#fff;
    padding:12px;
    border-radius:8px;
    margin-bottom:18px;
    transition:0.3s;
}

.contact-box input:focus,
.contact-box textarea:focus{
    outline:none;
    border-color:#FFD700;
    box-shadow:0 0 18px rgba(212,175,55,0.8);
}

/* ===== BUTTON ===== */
.btn-gold{
    background:linear-gradient(45deg,#d4af37,#f5e6b0);
    color:#000;
    font-weight:bold;
    padding:12px 34px;
    border-radius:30px;
    border:none;
    box-shadow:0 0 20px rgba(212,175,55,0.8);
    transition:0.3s;
    cursor:pointer;
}

.btn-gold:hover{
    background:linear-gradient(45deg,#f5e6b0,#d4af37);
    box-shadow:0 0 40px rgba(212,175,55,1);
}

/* ===== INFO ===== */
.contact-info p{
    font-size:16px;
    margin-bottom:16px;
    text-align:left;
    transition:0.3s;
}

.contact-info p:hover{
    transform:translateX(6px);
}

.contact-info span{
    color:#d4af37;
    margin-right:8px;
}

  /* Footer */
        footer {
            text-align: center;
            padding: 25px;
            background: #050505;
            color: #bfa63a;
            font-size: 14px;
        }
        
        /* ===== REGISTER BUTTON GOLDEN ===== */
.btn-gold{
    background: linear-gradient(135deg, #d4af37, #f5e6b0);
    color: #000;
    font-weight: 600;
    border: none;
    border-radius: 30px;   /* rounded */
    padding: 6px 18px;
}

.btn-gold:hover{
    background: linear-gradient(135deg, #f5e6b0, #d4af37);
    color: #000;
}
.footer-bottom{
    text-align:center;
    padding:25px 0;
    background:#050505;
    font-size:14px;
}


.footer-bottom{
    text-align:center;
    padding:25px 0;
    background:#050505;
    color:#ffffff !important;   /* white text */
    font-size:14px;
}

     
</style>

<!-- CONTACT SECTION -->
<section class="section-dark">

    <h2 class="section-title">Get In Touch</h2>
    <p class="section-subtitle">
        Experience elegance, relaxation and luxury at GoldenGlow.
    </p>

    <div class="contact-container">

        <!-- FORM -->
        <div class="contact-box">
            <form>
                <label>Your Name</label>
                <input type="text" placeholder="Enter your full name" required>

                <label>Email Address</label>
                <input type="email" placeholder="example@luxury.com" required>

                <label>Your Message</label>
                <textarea rows="4" placeholder="How can we assist you today?" required></textarea>

                <center>
                    <button class="btn-gold">Send Message</button>
                </center>
            </form>
        </div>

        <!-- INFO -->
        <div class="contact-box contact-info">
            <p><span>📍</span>GoldenGlow Luxury Salon, Pune, India</p>
            <p><span>📞</span>+91 98765 43210</p>
            <p><span>✉️</span>support@goldenglow.com</p>
            <p><span>⏰</span>Mon – Sun : 10 AM – 9 PM</p>

            <hr style="border-color:#d4af37; margin:20px 0;">

            <p>
                Experience premium Thai-inspired salon and spa services
                designed to relax, rejuvenate, and elevate your beauty.
            </p>

            <div class="map-box">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3780.7872026152145!2d73.7835135!3d18.6286387!2m3!1f0!2f0!3f0!3m2!1i1024!2f768!4f13.1!3m3!1m2!1s0x3bc2b9ba18f3e239%3A0x3744fbd91a39a431!2sHabibs%20Hair%20and%20Beauty%20Salon%20Elpro%20Mall!5e0!3m2!1sen!2sin!4v1770203182681!5m2!1sen!2sin"
                    allowfullscreen="" loading="lazy">
                </iframe>
            </div>

        </div>

    </div>
    

</section>
<div class="footer-bottom">
    © 2026 GoldenGlow Salon Management System | Designed for Luxury <span>❤</span>
</div>





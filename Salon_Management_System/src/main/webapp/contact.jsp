<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="header.jsp" %>

<style>
/* ===== GLOBAL ===== */
body{
    background:#000;
    color:#e6d8a8;
    font-family:'Playfair Display', serif;
}

/* ===== HERO ===== */
.contact-hero{
    height:60vh;
    background:
        linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.9)),
        url("images/thai-spa.jpg") center/cover no-repeat;
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    margin-top:90px;
}

.contact-hero h1{
    font-size:52px;
    color:#d4af37;
    letter-spacing:2px;
    text-shadow:0 0 20px rgba(212,175,55,0.7);
}

.contact-hero p{
    font-size:18px;
    color:#f5e6b0;
}

/* ===== SECTION ===== */
.section-dark{
    background:#0a0a0a;
    padding:70px 15%;
    text-align:center;
}

.section-title{
    font-size:36px;
    color:#d4af37;
    border-bottom:2px solid #d4af37;
    display:inline-block;
    padding-bottom:8px;
    margin-bottom:25px;
}

/* ===== CONTACT BOX ===== */
.contact-container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:40px;
    margin-top:40px;
}

.contact-box{
    background:#111;
    border:1px solid #d4af37;
    border-radius:18px;
    padding:35px;
    box-shadow:inset 0 0 18px rgba(212,175,55,0.4);
}

.map-box{
    margin-top: 25px;
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid rgba(212,175,55,0.5);
    box-shadow: inset 0 0 15px rgba(212,175,55,0.25);
}

.map-box iframe{
    width: 100%;
    height: 230px;
    border: 0;
    filter: grayscale(100%) contrast(1.1) brightness(0.85);
     filter: none !important;
    -webkit-filter: none !important;
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
    background:#000;
    border:1px solid #d4af37;
    color:#fff;
    padding:10px;
    border-radius:8px;
    margin-bottom:15px;
}

.contact-box input:focus,
.contact-box textarea:focus{
    outline:none;
    box-shadow:0 0 12px rgba(212,175,55,0.7);
}

/* ===== BUTTON ===== */
.btn-gold{
    background:linear-gradient(45deg,#d4af37,#f5e6b0);
    color:#000;
    font-weight:bold;
    padding:12px 34px;
    border-radius:30px;
    border:none;
    box-shadow:0 0 18px rgba(212,175,55,0.8);
    cursor:pointer;
}

/* ===== INFO ===== */
.contact-info p{
    font-size:16px;
    margin-bottom:14px;
    text-align:left;
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
</style>

<!-- CONTACT SECTION -->
<section class="section-dark">
    <h2 class="section-title">Get In Touch</h2>

    <div class="contact-container">

        <!-- FORM -->
        <div class="contact-box">
            <form>
                <label>Your Name</label>
                <input type="text" required>

                <label>Email Address</label>
                <input type="email" required>

                <label>Your Message</label>
                <textarea rows="4" required></textarea>

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

            <hr style="border-color:#d4af37">

            <p>
                Experience premium Thai-inspired salon and spa services
                designed to relax, rejuvenate, and elevate your beauty.
            </p>
            <div class="map-box">
   <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3780.7872026152145!2d73.7835135!3d18.6286387!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2b9ba18f3e239%3A0x3744fbd91a39a431!2sHabibs%20Hair%20and%20Beauty%20Salon%20Elpro%20Mall!5e0!3m2!1sen!2sin!4v1770203182681!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
</div>
        </div>

    </div>
</section>

<!-- Footer -->
<footer>
    © 2026 GoldenGlow Salon Management System | Designed for Luxury <span>❤</span>
</footer>


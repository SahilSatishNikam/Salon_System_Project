<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>
/* ===== GLOBAL ===== */
body{
    background:#0b0b0b;
    color:#e6d8a8;
    font-family:'Playfair Display', serif;
    
}

/* ===== HERO ===== */
.thai-hero{
    background:
        linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.9)),
        url("images/thai-spa.jpg") center/cover no-repeat;
    padding:120px 20px ;
    margin-top:100px;
   
}

.luxury-title{
    font-size:48px;
    color:#d4af37;
    letter-spacing:2px;
    text-shadow:0 0 18px rgba(212,175,55,0.6);
}

.luxury-subtitle{
    font-size:18px;
    color:#f5e6b0;
}

/* ===== BUTTON ===== */
.btn-gold{
    background:linear-gradient(45deg,#d4af37,#f5e6b0);
    color:#000;
    font-weight:bold;
    padding:10px 28px;
    border-radius:30px;
    box-shadow:0 0 15px rgba(212,175,55,0.7);
    border:none;
}

/* ===== SECTION ===== */
.luxury-section{
    margin-bottom:65px;
}

.luxury-section.row{
gap:30px;
}

.col-md-6 {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.luxury-heading{
    font-size:32px;
    color:#d4af37;
    border-bottom:2px solid #d4af37;
    display:inline-block;
    padding-bottom:6px;
    margin-bottom:20px;
}

.luxury-text{
    color:#e6d8a8;
    max-width:850px;
}

/* ===== HOW IT WORKS ===== */
.luxury-box{
    background:rgba(255,255,255,0.05);
    border:1px solid #d4af37;
    padding:30px 15px;
    border-radius:14px;
    transition:0.4s;
}

.luxury-box i{
    font-size:28px;
    color:#d4af37;
    margin-bottom:10px;
}

.luxury-box:hover{
    transform:translateY(-8px);
    box-shadow:0 0 25px rgba(212,175,55,0.6);
}

/* ===== SALON CARDS ===== */
/* ===== FEATURED SALONS ===== */
.featured-section{
    padding:60px 80px;
}

.featured-title{
    font-size:32px;
    color:#d4af37;
    margin-bottom:40px;
    border-bottom:2px solid #d4af37;
    display:inline-block;
    padding-bottom:10px;
}

.featured-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
    gap:30px;
}

.salon-card{
    background:#0e0e0e;
    border-radius:18px;
    overflow:hidden;
    box-shadow:0 0 25px rgba(212,175,55,0.15);
    transition:0.4s ease;
    border:1px solid rgba(212,175,55,0.3);
}

.salon-card:hover{
    transform:translateY(-8px);
    box-shadow:0 0 45px rgba(212,175,55,0.5);
}

.salon-img{
    height:200px;
    overflow:hidden;
}

.salon-img img{
    width:100%;
    height:100%;
    object-fit:cover;
    transition:0.5s ease;
}

.salon-card:hover img{
    transform:scale(1.08);
}

.salon-info{
    padding:22px;
    text-align:center;
}

.salon-info h3{
    color:#f5e6b0;
    font-size:20px;
    margin-bottom:10px;
}

.salon-info p{
    font-size:14px;
    color:#ccc;
    line-height:1.6;
}

.salon-info a{
    display:inline-block;
    margin-top:15px;
    padding:10px 25px;
    border-radius:25px;
    text-decoration:none;
    color:#000;
    font-weight:600;
    background:linear-gradient(45deg,#d4af37,#f5e6b0);
}

/* ===== SERVICES ===== */
.luxury-list{
    list-style:none;
    padding-left:0;
}

.luxury-list li{
    padding:12px 0;
    border-bottom:1px solid #333;
    position:relative;
    padding-left:22px;
}

.luxury-list li::before{
    content:"✦";
    color:#d4af37;
    position:absolute;
    left:0;
}

/* ===== SCROLLABLE FEEDBACK ===== */
.feedback-section{
    margin:90px 0;
}

.feedback-wrapper{
    display:flex;
    gap:25px;
    overflow-x:auto;
    padding:30px 15px;
    scroll-snap-type:x mandatory;
}

.feedback-wrapper::-webkit-scrollbar{
    height:8px;
}

.feedback-wrapper::-webkit-scrollbar-thumb{
    background:#d4af37;
    border-radius:20px;
}

.feedback-card{
    min-width:320px;
    background:rgba(255,255,255,0.06);
    border:1px solid #d4af37;
    border-radius:18px;
    padding:26px;
    scroll-snap-align:start;
    transition:0.4s;
}

.feedback-card:hover{
    transform:translateY(-10px);
    box-shadow:0 0 35px rgba(212,175,55,0.7);
}

.feedback-stars{
    color:#d4af37;
    font-size:18px;
    margin-bottom:10px;
}

.feedback-text{
    font-size:15px;
    color:#e6d8a8;
    line-height:1.7;
}

.feedback-user{
    margin-top:15px;
    font-weight:bold;
    color:#d4af37;
}


/* ===== CONTACT ICONS ===== */
.luxury-text i{
    color:#d4af37;
    margin-right:8px;
}

body{
    margin:0;
    font-family:'Playfair Display', serif;
    background:#0b0b0b;
    color:#e6d8a8;
}

/* ===== SECTION ===== */
.services-section{
    padding:90px 0;
}

.services-container{
    max-width:1200px;
    margin:auto;
    display:flex;
    gap:70px;
    align-items:center;
}

/* ===== LEFT IMAGE ===== */
.services-image{
    flex:1;
    height:620px;
    position:relative;
    border-radius:6px;
    overflow:hidden;
}

.services-image img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.services-image::after{
    content:"";
    position:absolute;
    inset:0;
    background:linear-gradient(
        rgba(0,0,0,0.35),
        rgba(212,175,55,0.55)
    );
}

/* ===== RIGHT CONTENT ===== */
.services-content{
    flex:1.2;
}

.services-content h2{
    font-size:44px;
    letter-spacing:3px;
    color:#d4af37;
}

.services-desc{
    color:#e6d8a8;
    margin:25px 0 45px;
    line-height:1.9;
    max-width:520px;
}

/* ===== GRID ===== */
.service-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:38px 45px;
}

.service-box{
    display:flex;
    gap:18px;
    align-items:flex-start;
    transition:0.3s;
}

/* ICON BOX */
.icon-box{
    width:56px;
    height:56px;
    border:1px solid #d4af37;
    display:flex;
    align-items:center;
    justify-content:center;
    background:rgba(212,175,55,0.08);
}

.icon-box i{
    font-size:26px;
    color:#d4af37;
}

/* ACTIVE SERVICE (BEARD) */
.service-box.active .icon-box{
    background:#d4af37;
}

.service-box.active i{
    color:#000;
}

/* TEXT */
.service-box h4{
    font-size:15px;
    margin:0 0 8px;
    letter-spacing:1px;
    color:#f5e6b0;
}

.service-box p{
    font-size:14px;
    color:#e6d8a8;
    line-height:1.6;
    margin:0;
}

/* HOVER EFFECT */
.service-box:hover{
    transform:translateY(-6px);
}
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins', sans-serif;
}

body{
    background:#0b0b0b;
}

/* ===== HERO SECTION ===== */
.hero{
    display:flex;
    align-items:center;
    justify-content:space-between;
    height:100vh;
    padding:0 8%;
    background:#111;
    color:#fff;
     background-image:url("images/salon1.jpg"); /* change image */
    background-size:cover;
    background-position:center;
}

/* LEFT IMAGE */
.hero-img{
    flex:1;
    display:flex;
    justify-content:center;
}
.hero-img img{
    max-height:90vh;
    width:auto;
    border-radius:50px;
    margin-top:20px
}

/* RIGHT CONTENT */
.hero-content{
    flex:1;
    padding-left:50px;
}

.hero-content h5{
    color:#c89b6d;
    font-weight:500;
    letter-spacing:1px;
    margin-bottom:15px;
}

.hero-content h1{
    font-size:64px;
    font-weight:700;
    line-height:1.1;
}

.hero-content h1 span{
    color:#c89b6d;
}

.hero-content p{
    margin:20px 0;
    font-size:15px;
    color:#ddd;
}

/* SERVICES LINE */
.services{
    margin:15px 0 35px;
    font-size:14px;
    color:#cfcfcf;
}
.services span{
    color:#c89b6d;
    margin:0 8px;
}

/* BUTTONS */
.hero-buttons{
    display:flex;
    gap:20px;
}

.hero-buttons a{
    text-decoration:none;
    padding:14px 28px;
    border-radius:4px;
    font-size:14px;
    letter-spacing:0.5px;
    transition:0.3s;
}

.btn-men{
    background:#c89b6d;
    color:#000;
}

.hero-buttons a:hover{
    transform:translateY(-3px);
    opacity:0.9;
}

/* RESPONSIVE */
@media(max-width:900px){
    .hero{
        flex-direction:column;
        padding:40px 5%;
        height:auto;
        text-align:center;
    }
    .hero-content{
        padding-left:0;
        margin-top:30px;
    }
    .hero-content h1{
        font-size:48px;
    }
    }
    
    /* ===== HERO CONTENT ===== */
.hero-content{
    max-width:620px;
}

.hero-content h4{
    font-size:14px;
    letter-spacing:3px;
    color:#d4af37;
    margin-bottom:16px;
    font-weight:600;
}

.hero-content h1{
    font-size:64px;
    line-height:1.15;
    color:#d4af37;
    margin-bottom:22px;
}

.hero-content h1{
    color:#d4af37;
    text-shadow:0 0 20px rgba(212,175,55,0.7);
    font-weigth:bold;
    font-size:64px;
    line-height:1.15;
}

/* ===== SERVICES LINE ===== */
.services{
    font-size:14px;
    color:#dcdcdc;
    line-height:1.8;
    margin-bottom:35px;
}

.services span{
    color:#d4af37;
    margin:0 8px;
    font-weight:bold;
}

/* ===== BUTTON ===== */
/* ===== GOLD LUXURY BUTTON ===== */
.btn-appointment{
    display:inline-block;
    padding:14px 40px;
    font-size:16px;
    font-weight:600;
    text-decoration:none;
    color:#000;
    border-radius:30px;

    /* gold gradient */
    background:linear-gradient(45deg,#d4af37,#f5e6b0);

    border:1px solid #d4af37;
    box-shadow:0 0 18px rgba(212,175,55,0.45);
    transition:0.4s ease;
}

/* hover effect */
.btn-appointment:hover{
    background:#000;
    color:#d4af37;
    box-shadow:0 0 35px rgba(212,175,55,0.85);
    transform:translateY(-3px);
}

.how-it-works{
    padding:100px 8%;
    background:linear-gradient(180deg,#000,#0b0b0b);
    text-align:center;
}

/* Title */
.section-title{
    font-size:38px;
    color:#d4af37;
    margin-bottom:70px;
    letter-spacing:2px;
    position:relative;
}

.section-title::after{
    content:'';
    width:80px;
    height:2px;
    background:#d4af37;
    display:block;
    margin:14px auto 0;
}

/* Steps */
.steps-container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:40px;
}

/* Card */
.step-card{
    background:rgba(255,255,255,0.03);
    border:1px solid rgba(212,175,55,0.4);
    padding:45px 25px;
    border-radius:50px;
    transition:.4s ease;
    position:relative;
    overflow:hidden;
}

.step-card i{
    font-size:34px;
    color:#d4af37;
    margin-bottom:20px;
}

.step-card h4{
    color:#f5e6b0;
    font-size:18px;
    margin-bottom:10px;
}

.step-card p{
    font-size:14px;
    color:#cfcfcf;
    line-height:1.6;
}

/* Step number */
.step-number{
    position:absolute;
    top:15px;
    right:20px;
    font-size:34px;
    font-weight:700;
    color:rgba(212,175,55,0.15);
}

/* Hover effect */
.step-card:hover{
    transform:translateY(-12px);
    box-shadow:0 0 35px rgba(212,175,55,.6);
    border-color:#d4af37;
}

/* Active (highlight) */
.step-card.active{
    background:linear-gradient(180deg,#111,#000);
    box-shadow:0 0 45px rgba(212,175,55,.8);
}
    

</style>

<!-- HERO SECTION -->
<section class="hero">

    <!-- LEFT IMAGE -->
    <div class="hero-img">
        <!-- replace image path -->
        
    </div>

    <!-- RIGHT CONTENT -->
    <div class="hero-content mt-5">
        <h4>RANGE OF WOMEN'S SERVICES FOR YOUR</h4>

        <h1>GOLDEN</h1>
        <b><h1>GLOW</h1></b>

        <div class="services">
           <b>Haircut & Color <span>|</span>
            Threading & Waxing <span>|</span>
            Highlights & Balayage <span>|</span>
            Facials & Treatment <span>|</span>
            Upto & Makeup</b>
        </div>

        <div class="hero-buttons">
            <a href="appointment.jsp" class="btn-appointment">Book Appointment</a>
        </div>
    </div>

</section>

    <!-- HOW IT WORKS -->
   <section class="how-it-works">

    <h2 class="section-title">How It Works</h2>

    <div class="steps-container">

        <div class="step-card">
           
            <i class="fa fa-search"></i>
            <h4>Search Salon</h4>
            <p>Find premium salons near you.</p>
        </div>

        <div class="step-card">
           
            <i class="fa fa-spa"></i>
            <h4>Choose Service</h4>
            <p>Select the service you love.</p>
        </div>

        <div class="step-card">
            
            <i class="fa fa-calendar-check"></i>
            <h4>Book Appointment</h4>
            <p>Book instantly at your convenience.</p>
        </div>

        <div class="step-card">
          
            <i class="fa fa-gem"></i>
            <h4>Enjoy Luxury</h4>
            <p>Relax & glow with premium care.</p>
        </div>

    </div>
</section>

    <!-- FEATURED SALONS -->
    <section class="featured-section">
    <center><div class="featured-title">Featured Salons</div></center>

    <div class="featured-grid">

        <!-- SALON 1 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/salon1.jpg" alt="Golden Orchid Spa">
            </div>
            <div class="salon-info">
                <h3>Golden Orchid Spa</h3>
                <p>Premium spa experience with calming ambience and expert therapists.</p>
               
            </div>
        </div>

        <!-- SALON 2 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/salon2.jpg" alt="Bangkok Bliss Salon">
            </div>
            <div class="salon-info">
                <h3>Bangkok Bliss Salon</h3>
                <p>Authentic Thai treatments with modern luxury touch.</p>
               
            </div>
        </div>

        <!-- SALON 3 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/salon3.jpeg" alt="Royal Thai Beauty">
            </div>
            <div class="salon-info">
                <h3>Royal Thai Beauty</h3>
                <p>Royal-grade beauty services with premium products.</p>
                
            </div>
        </div>

    </div>
</section>


    <!-- POPULAR SERVICES -->
 <section class="services-section">
<div class="services-container">

    <!-- LEFT IMAGE -->
    <div class="services-image">
        <img src="images/services.jpeg" alt="Salon Services">
    </div>

    <!-- RIGHT CONTENT -->
    <div class="services-content mt-1">
        <h2>SERVICES</h2>
        <p class="services-desc">
            Outlook Salon & Spa provides the best-in-class styling services
            with a premium luxury experience for men and women.
        </p>

        <div class="service-grid">

            <!-- HAIRCUT -->
            <div class="service-box">
                <div class="icon-box">
                    <i class="fa-solid fa-scissors"></i>
                </div>
                <div>
                    <h4>HAIRCUTS</h4>
                    <p>All types of modern and classic haircuts.</p>
                </div>
            </div>

<!-- BEARD -->
<div class="service-box">
    <div class="icon-box">
        <i class="fa-solid fa-user"></i>
    </div>
    <div>
        <h4>BEARD</h4>
        <p>Beard trimming, line-up and grooming services.</p>
    </div>
</div>

            <!-- COLORS -->
            <div class="service-box">
                <div class="icon-box">
                    <i class="fa-solid fa-fill-drip"></i>
                </div>
                <div>
                    <h4>COLORS</h4>
                    <p>Hair coloring, highlights and root touch-ups.</p>
                </div>
            </div>

            <!-- THREADING -->
            <div class="service-box">
                <div class="icon-box">
                    <i class="fa-solid fa-hand-sparkles"></i>
                </div>
                <div>
                    <h4>THREADING & WAXING</h4>
                    <p>Eyebrow threading and waxing services.</p>
                </div>
            </div>

            <!-- HOT TOWEL -->
            <div class="service-box">
                <div class="icon-box">
                    <i class="fa-solid fa-wind"></i>
                </div>
                <div>
                    <h4>HOT TOWEL SHAVE</h4>
                    <p>Luxury hot towel shave experience.</p>
                </div>
            </div>

            <!-- KIDS -->
            <div class="service-box">
                <div class="icon-box">
                    <i class="fa-solid fa-child"></i>
                </div>
                <div>
                    <h4>KIDS HAIRCUT</h4>
                    <p>Comfortable and stylish haircuts for kids.</p>
                </div>
            </div>

        </div>
    </div>

</div>
</section>



<%@ include file="footer.jsp" %>





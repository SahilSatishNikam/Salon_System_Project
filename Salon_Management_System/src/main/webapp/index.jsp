<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>
/* =====================================================
   GLOBAL RESET + FONT
   ===================================================== */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body,
h1, h2, h3, h4, h5, h6,
p, span:not(i),
div,
a,
ul, li,
label,
small,
button,
input,
textarea {
    font-family:"Times New Roman", Times, serif !important;
}

body{
    background:#0b0b0b;
    color:#e6d8a8;
}
/* ===== ICONIC TRANSFORMATION ===== */

.transform-section{
    background:#0b0b0b;
    padding:90px 60px;
    text-align:center;
    font-family:"Times New Roman", serif;
}

.transform-sub{
    color:#d4af37;
    font-size:18px;
    letter-spacing:3px;
    margin-bottom:10px;
}

.transform-title{
    font-size:38px;
    color:#d4af37;
    margin-bottom:60px;
}

/* grid */
.transform-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(400px,1fr));
    gap:40px;
}

/* card */
.transform-card{
    background:#111;
    padding:20px;
    border-radius:18px;
    border:1px solid rgba(212,175,55,0.3);
    box-shadow:0 0 25px rgba(212,175,55,0.15);
    transition:.4s;
    
}

.transform-card:hover{
    transform:translateY(-8px);
    box-shadow:0 0 45px rgba(212,175,55,0.6);
}

/* images side by side */
.transform-images{
    display:flex;
    gap:15px;
}

.img-wrap{
    position:relative;
    flex:1;
}

.img-wrap img{
    width:100%;
    height:220px;
    object-fit:cover;
    border-radius:12px;
}

/* badges */
.tag{
    position:absolute;
    top:10px;
    left:10px;
    padding:4px 10px;
    font-size:11px;
    border-radius:12px;
    font-weight:600;
}

.before{
    background:#444;
    color:#fff;
}

.after{
    background:#d4af37;
    color:#000;
}

/* text */
.transform-card h4{
    color:#f5e6b0;
    margin:15px 0 5px;
}

.transform-card p{
    color:#ccc;
    font-size:16px;
}

/* text */
.iconic-card h4{
    color:#f5e6b0;
    margin:15px 0 5px;
    font-size:17px;
}

.iconic-card p{
    color:#ccc;
    font-size:14px;
    padding-bottom:20px;
}

/* BADGE */
.badge{
    position:absolute;
    top:15px;
    left:15px;
    padding:4px 10px;
    font-size:11px;
    border-radius:20px;
    font-weight:bold;
}

.before{
    background:#444;
    color:white;
}

.after{
    background:#ff4d6d;
    color:white;
}

/* ===== LETTER BY LETTER ANIMATION ===== */
/* ===== GOLD LETTER ANIMATION ===== */
.gold-letter span{
    display:inline-block;
    opacity:0;
    transform: translateY(40px);

    /* GOLD COLOR */
    background: linear-gradient(
        120deg,
        #b8860b,
        #ffd700,
        #fff1a8,
        #ffd700,
        #b8860b
    );
    background-size:300% auto;
    color:transparent;
    background-clip:text;
    -webkit-background-clip:text;

    animation:
        letterReveal 0.8s ease forwards,
        goldShimmer 4s linear infinite;
}

/* reveal animation */
@keyframes letterReveal{
    to{
        opacity:1;
        transform: translateY(0);
    }
}

/* shimmer movement */
@keyframes goldShimmer{
    from{ background-position:0% center; }
    to{ background-position:300% center; }
}

/* stagger delay */
.gold-letter span:nth-child(1){animation-delay:0.1s;}
.gold-letter span:nth-child(2){animation-delay:0.2s;}
.gold-letter span:nth-child(3){animation-delay:0.3s;}
.gold-letter span:nth-child(4){animation-delay:0.4s;}
.gold-letter span:nth-child(5){animation-delay:0.5s;}
.gold-letter span:nth-child(6){animation-delay:0.6s;}
.gold-letter span:nth-child(7){animation-delay:0.7s;}
.gold-letter span:nth-child(8){animation-delay:0.8s;}
.gold-letter span:nth-child(9){animation-delay:0.9s;}
.gold-letter span:nth-child(10){animation-delay:1s;}




/* =====================================================
   GOLD SHIMMER ANIMATION
   ===================================================== */
@keyframes goldShimmer{
    0%{ background-position:-200% center; }
    100%{ background-position:200% center; }
}

/* ===== HERO ===== */
.thai-hero{
    background:
        linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.9)),
        url('https://headcurve.com/wp-content/uploads/2018/12/hair-salon-interior-design-dec12-00022.jpg');
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
    font-family: "Times New Roman", Times, serif !important;
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

 /* ===== PREMIUM HOW IT WORKS ===== */

.how-luxury{
    background:#0b0b0b;
    padding:15px 35px;;
    text-align:center;
    font-family:"Times New Roman", serif;
}

/* heading */
.how-luxury h2{
    font-size:38px;
    color:#d4af37;
    margin-bottom:10px;
}

.how-luxury p{
    color:#aaa;
    max-width:600px;
    margin:0 auto 80px;
     font-size:20px;
}

/* line */
.lux-line{
    position:relative;
    max-width:1100px;
    margin:auto;
  font-size:20px;
}

.lux-line::before{
    content:'';
    position:absolute;
    top:35px;
    left:0;
    width:100%;
    height:2px;
    background:linear-gradient(to right,#000,#d4af37,#000);
}

/* steps */
.lux-steps{
    display:flex;
    justify-content:space-between;
    gap:40px;
}

/* step */
.lux-step{
    width:25%;
    text-align:center;
}

/* icon circle */
.lux-icon{
    width:70px;
    height:70px;
    border-radius:50%;
    background:#111;
    border:2px solid #d4af37;
    margin:auto;

    display:flex;
    align-items:center;
    justify-content:center;

    box-shadow:0 0 25px rgba(212,175,55,.6);
    transition:.4s;
}

/* icon */
.lux-icon i{
    color:#d4af37;
    font-size:26px;
}

/* hover glow */
.lux-step:hover .lux-icon{
    transform:scale(1.2);
    box-shadow:0 0 50px #d4af37;
}

/* text */
.lux-step h4{
    color:#d4af37;
    margin-top:20px;
    font-size:22px;
}

.lux-step p{
    color:#aaa;
    font-size:20px;
    margin-top:10px;
}

/* responsive */
@media(max-width:900px){
    .lux-steps{
        flex-direction:column;
        gap:50px;
    }
    .lux-line::before{
        display:none;
    }
}
/* ===== SALON CARDS ===== */
/* ===== FEATURED SALONS ===== */
.featured-section{
   background: #0b0b0b;   /* pure black */

    padding:40px 60px;
    text-align:center;
    ackground:#0b0b0b;
}

/* ===== TITLE ===== */
.featured-title{
    font-family: "Times New Roman", Times, serif;
    font-size:38px;
    color:#d4af37;
    margin-bottom:60px;
}

/* ===== GRID (Smaller Boxes) ===== */
.featured-grid{
    display:grid;
    grid-template-columns:repeat(3, 420px); /* smaller fixed width */
    justify-content:center; /* center cards */
    gap:30px;
}

/* ===== CARD ===== */
.salon-card{
    background:#0a0a0a;
    border-radius:16px;
    overflow:hidden;
    border:1px solid rgba(212,175,55,0.25);
    box-shadow:0 0 20px rgba(212,175,55,0.08);
    transition:0.4s ease;
}

.salon-card:hover{
    transform:translateY(-8px);
    box-shadow:0 0 40px rgba(212,175,55,0.35);
}

/* ===== IMAGE (Smaller) ===== */
.salon-img{
    height:240px;  /* reduced from 300px */
    overflow:hidden;
}

.salon-img img{
    width:100%;
    height:100%;
    object-fit:cover;
    transition:0.5s ease;
}

.salon-card:hover img{
    transform:scale(1.05);
}

/* ===== INFO ===== */
.salon-info{
    padding:22px;
    
}

.salon-info h3{
    color:#d4af37;
    font-family: "Times New Roman", Times, serif;
    font-size:20px;
    margin-bottom:12px;
}

.salon-info p{
    color:#ccc;
    font-size:17px;
    line-height:1.6;
}

/* ===== SERVICES ===== */
.luxury-list{
    list-style:none;
    padding-left:0;
    font-family: "Times New Roman", Times, serif !important;
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
    font-family: "Times New Roman", Times, serif !important;
    background:#0b0b0b;
    color:#e6d8a8;
}

/* =====  SERVICES SECTION ===== */
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
    height:500px;
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
    font-size:38px;
   font-family: "Times New Roman", Times, serif;
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
    font-size:20px;
    margin:0 0 8px;
    letter-spacing:1px;
    color:#f5e6b0;
}

.service-box p{
    font-size:18px;
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
.services{
    width:100%;
    display:flex;
    justify-content:center;   /* horizontal center */
    align-items:center;       /* vertical center */
    background:rgba(0,0,0,0.7);
    padding:15px 0;
    margin-top:20px;
}

.service{
    color:#fff;
    font-weight:500;
    text-align:center;
    letter-spacing:1px;
}


/* ===== HERO SECTION ===== */
.hero{
    min-height:100vh;
    background:
        linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.75)),
        url("https://img.freepik.com/premium-photo/luxurious-salon-interior-with-soft-tones-elegant-modern-design_1025753-152493.jpg?w=1400");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;

    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    padding:40px 20px;
    animation:
        fadeSlideGold 1.5s ease-out forwards,
        goldShimmer 4s linear infinite;
}

/* LEFT IMAGE */
.hero-img{
    flex:1;
    display:flex;
    justify-content:center;
     display:none;
}
.hero-img img{
    max-height:90vh;
    width:auto;
    border-radius:50px;
    margin-top:20px
}

/* RIGHT CONTENT */
.hero-content{
    max-width:900px;
}


.hero-content h5{
    color:#c89b6d;
    font-weight:500;
    letter-spacing:1px;
    margin-bottom:15px;
}

@keyframes fadeSlideGold {
    0%{
        opacity: 0;
        transform: translateY(30px);
    }
    100%{
        opacity: 1;
        transform: translateY(0);
    }
}
.hero-content h1{
    font-size:64px;
    font-weight:700;
    line-height:1.15;
    margin-bottom:22px;
    animation:
        fadeSlideGold 1.5s ease-out forwards,
        goldShimmer 4s linear infinite;

    background:linear-gradient(
        120deg,
        #b8860b 0%,
        #ffd700 25%,
        #fff1a8 50%,
        #ffd700 75%,
        #b8860b 100%
    );
    background-size:300% auto;
    color:transparent;
    background-clip:text;
    -webkit-background-clip:text;

    animation:goldShimmer 4s linear infinite;
    text-shadow:0 0 25px rgba(212,175,55,0.5);
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
    font-size:18px;
    color:#ffffff;
    background:rgba(0,0,0,0.65);
    padding:12px 18px;
    border-radius:8px;
    line-height:1.8;
    margin:18px 0 32px;
    display:inline-block;
    box-shadow:0 0 20px rgba(212,175,55,0.2);
}
.services span{
    color:#d4af37;
    font-weight:bold;
    margin:0 8px;
}

/* BUTTONS */
.hero-buttons{
    display:flex;
    gap:20px;
    margin-top: 10px;
    text-align: center;
    justify-content: center;
    align-items: center;
    
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
        min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    gap: 30px;
    }
    .hero-content{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
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
    font-size:20px;
    letter-spacing:4px;
    color:#d4af37;
    margin-bottom:18px;
    text-shadow:0 0 10px rgba(212,175,55,0.4);
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
	white-space: nowrap;      /* force single line */
    overflow: hidden;         /* hide overflow */
    text-overflow: ellipsis; 
    font-size:20px;
    color:#ffffff;
    background:#00000094;
    line-height:1.8;
     margin: 15px 0 30px;
    font-family: "Times New Roman", Times, serif !important;
    
}

.services span{
    color:#d4af37;
    font-weight:bold;
    margin: 0 8px;
    color: #d4af37;
}
.services,
.services b,
.services span {
    font-family: "Times New Roman", Times, serif !important;
}


/* ===== BUTTON ===== */
/* ===== GOLD LUXURY BUTTON ===== */
.btn-appointment{
    display:inline-block;
    padding:14px 40px;
   font-size:26px;      /* increased text size */
    font-weight:700; 

    text-decoration:none;
    color:#000;
    border-radius:30px;

    background:linear-gradient(45deg,#d4af37,#f5e6b0);
    border:1px solid #d4af37;

    box-shadow:0 0 18px rgba(212,175,55,0.5);
    transition:0.4s ease;
    position:relative;
    overflow:hidden;
}

.btn-appointment::after{
    content:'';
    position:absolute;
    top:0;
    left:-150%;
    width:150%;
    height:100%;
    background:linear-gradient(
        120deg,
        transparent 30%,
        rgba(255,255,255,0.6) 50%,
        transparent 70%
    );
    transition:0.6s;
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
    text-align:center;
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
.luxury-box,
.step-card,
.feedback-card{
    background:rgba(255,255,255,0.04);
    border:1px solid rgba(212,175,55,0.4);
    border-radius:18px;
    transition:0.4s ease;
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

    

</style>

<!-- HERO SECTION -->
<section class="hero">

    <!-- LEFT IMAGE -->
    <div class="hero.jpg">
        <!-- replace image path -->
        
    </div>

    <!-- RIGHT CONTENT -->
    <div class="hero-content mt-5">
        <h4>RANGE OF WOMEN'S SERVICES FOR YOUR</h4>

        <h1 class="gold-letter">
  <span>G</span><span>O</span><span>L</span><span>D</span><span>E</span><span>N</span><span>G</span><span>L</span><span>O</span><span>W</span>
</h1>
        

        <div class="services">
           <b>  Haircut & Color<span>|</span>
            Threading & Waxing<span>|</span>
            Highlights & Balayage <span>|</span>
            Facials & Treatment <span>|</span>
            Upto & Makeup</b>
        </div>

        <div class="hero-buttons">
            <a href="register.jsp" class="btn-appointment">Register Now</a>
        </div>
    </div>

</section>

    <!-- HOW IT WORKS -->
   <section class="how-luxury">

    <h2>How It Works</h2>

    <p>
        Experience seamless luxury from booking to glowing.
        Our process is designed for your ultimate convenience.
    </p>

    <div class="lux-line">

        <div class="lux-steps">

            <div class="lux-step">
                <div class="lux-icon">
                    <i class="fa fa-search"></i>
                </div>
                <h4>Search Salon</h4>
                <p>Find premium salons near you with curated services tailored to your needs.</p>
            </div>

            <div class="lux-step">
                <div class="lux-icon">
                    <i class="fa fa-spa"></i>
                </div>
                <h4>Choose Service</h4>
                <p>Select the service you love from revitalizing facials to styling.</p>
            </div>

            <div class="lux-step">
                <div class="lux-icon">
                    <i class="fa fa-calendar-check"></i>
                </div>
                <h4>Book Appointment</h4>
                <p>Secure your slot instantly with our real-time scheduling.</p>
            </div>

            <div class="lux-step">
                <div class="lux-icon">
                    <i class="fa fa-gem"></i>
                </div>
                <h4>Enjoy Luxury</h4>
                <p>Relax & glow with premium care and world-class hospitality.</p>
            </div>

        </div>

    </div>

</section>

<!--  TRANSFORMATION SECTION -->
<section class="transform-section">

    <p class="transform-sub">REAL RESULTS</p>
    <h2 class="transform-title">Iconic Transformations</h2>

    <div class="transform-grid">

        <!-- HAIR -->
        <div class="transform-card reveal">

            <div class="transform-images">
                <div class="img-wrap">
                    <span class="tag before">BEFORE</span>
                    <img src="images/Hair_Before.jpg">
                </div>

                <div class="img-wrap">
                    <span class="tag after">AFTER</span>
                    <img src="images/After1.jpg">
                </div>
            </div>

            <h4>Signature Keratin Treatment</h4>
<p>Professional smoothing treatment with deep nourishment & frizz elimination..</p>

        </div>

        <!-- SKIN -->
        <div class="transform-card reveal">

            <div class="transform-images">
                <div class="img-wrap">
                    <span class="tag before">BEFORE</span>
                    <img src="images/Before.jpg">
                </div>

                <div class="img-wrap">
                    <span class="tag after">AFTER</span>
                    <img src="images/After.jpg">
                </div>
            </div>

          <h4>Diamond Luxe Facial</h4>
<p>Luxury diamond exfoliation for radiant glow.</p>


        </div>

    </div>

</section>


    <!-- FEATURED SALONS -->
    <section class="featured-section">

    <h2 class="featured-title">Featured Salons</h2>

    <div class="featured-grid">

        <!-- Card 1 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/f1.jpg" alt="">
            </div>
            <div class="salon-info">
                <h3>Aura Beauty Studio</h3>
                <p>Enhancing your natural beauty with professional touch</p>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/f2.jpg" alt="">
            </div>
            <div class="salon-info">
                <h3>Golden Glow Spa</h3>
                <p>Luxury skincare and relaxation therapies.</p>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="salon-card">
            <div class="salon-img">
                <img src="images/f3.jpg" alt="">
            </div>
            <div class="salon-info">
                <h3>Royal Beauty</h3>
                <p>Premium beauty services with quality products.</p>
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
        <h2>Services</h2>
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
<%@ include file="footer.jsp" %>
</section>









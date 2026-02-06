<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us - Salon</title>

<style>
/* ===== STATS SECTION ===== */
.stats{
 display:flex;
 justify-content:space-around;
 align-items:center;

 background:#0e0c05;
 padding:70px 40px;
 text-align:center;
}

.stat h2{
 color:#c9a227;
 font-size:42px;
 margin:0;
 letter-spacing:2px;
}

.s-line{
 width:40px;
 height:1px;
 background:#c9a227;
 margin:10px auto;
}

.stat p{
 color:#aaa;
 font-size:12px;
 letter-spacing:3px;
}

/* ===== GLOBAL ===== */
body{
 margin:0;
 font-family:'Segoe UI',sans-serif;
 background:#0b0905;
 color:#fff;
}


/* ===== EXACT NAVBAR SECTION START STYLE ===== */

.navbar {
  display:flex;
  justify-content:space-between;
  align-items:center;

  background:#0a0a0a;
  border-bottom:1px solid rgba(255,215,0,0.2);

  padding:12px 60px;
  position:fixed;
  width:100%;
  top:0;
  z-index:9999;
}

/* LOGO SIDE */
.brand{
  display:flex;
  align-items:center;
  gap:8px;
  text-decoration:none;
}

.brand img{
  width:34px;
}

.brand-text{
  font-size:22px;
  font-weight:700;
  color:#fff;
}

.brand-text span{
  color:#ffd700;
}

/* NAV LINKS */
.nav-links{
  display:flex;
  align-items:center;
  gap:22px;
}

.nav-links a{
  color:#fff;
  text-decoration:none;
  font-size:15px;
  position:relative;
}

/* underline */
.nav-links a.active{
  color:#ffd700;
}

.nav-links a.active::after{
  content:'';
  position:absolute;
  left:0;
  bottom:-4px;
  width:100%;
  height:2px;
  background:#ffd700;
}

/* BUTTONS */
.login-btn{
  border:1px solid #fff;
  color:#fff;
  padding:6px 16px;
  border-radius:20px;
  text-decoration:none;
}

.register-btn{
  background:#ffd700;
  color:#000;
  padding:6px 16px;
  border-radius:20px;
  text-decoration:none;
}

/* ===== EXACT NAVBAR SECTION  END STYLE ===== */

/* ===== HERO ===== */
/* ===== HERO WITH IMAGE ===== */
.hero{
 text-align:center;
 padding:180px 0;

 /* ADD YOUR IMAGE HERE */
 background:
   linear-gradient(rgba(0,0,0,.75), rgba(0,0,0,.75)),
   url('images/hero.jpg');

 background-size:cover;
 background-position:center;
 background-attachment:fixed;

 animation:fadeDown 1s ease;
}


/* ===== HOW WE STARTED ===== */
/* ===== TITLE LOGO BEFORE TEXT ===== */
.tlogo{
 width:22px;
 height:22px;
 object-fit:contain;

 margin-right:8px;
 vertical-align:middle;
}

.title{
 text-align:center;
 font-size:34px;
 margin:40px 0;
 font-style:italic;
}


/* ===== TIMELINE ===== */

.timeline{
 width:86%;
 margin:auto;
}


/* ===== BLOCK ===== */
/* ----- CHANGED FOR SCROLL ANIMATION ----- */
.block{
 display:flex;
 align-items:center;
 gap:60px;
 margin-bottom:90px;

 opacity:0;
 transform:translateY(60px);
 transition:all .9s ease;
}

/* WHEN VISIBLE */
.block.show{
 opacity:1;
 transform:translateY(0);
}

/* alternate */
.block:nth-child(even){
 flex-direction:row-reverse;
}


/* ===== IMAGE EXACT SIZE ===== */
.block img{
 width:500px;
 height:320px;
 object-fit:cover;
 border:1px solid #2a2616;
 padding:6px;
 background:#0e0c05;
 transition:.4s ease;
}
.block img:hover{
 transform:scale(1.02);
 border-color:#c9a227;
}


/* ===== TEXT AREA (NO BOX) ===== */
.text{
 width:460px;
}


/* small golden line */
.line{
 width:40px;
 height:2px;
 background:#c9a227;
 margin-bottom:10px;

 /* line grow effect */
 transform:scaleX(0);
 transform-origin:left;
 transition:.8s ease;
}

.block.show .line{
 transform:scaleX(1);
}


.year{
 color:#c9a227;
 letter-spacing:2px;
}

.text h3{
 margin:8px 0;
 letter-spacing:1px;
}

.text p{
 opacity:.8;
 line-height:24px;
}
/* ===== ARTISANS SECTION ===== */

.art-section{
 background:#0b0905;
 padding:90px 40px;
 text-align:center;
}

.art-top small{
 color:#c9a227;
 letter-spacing:4px;
}

.art-top h2{
 font-size:44px;
 margin:10px 0 50px;
}

.art-top span{
 color:#c9a227;
 font-style:italic;
}


/* GRID */
.art-grid{
 display:flex;
 justify-content:center;
 gap:30px;
 flex-wrap:wrap;
}


/* CARD */
.art-card{
 width:320px;
 background:#0e0c05;
 border-radius:14px;
 overflow:hidden;
 border:1px solid #1e1b10;

 transition:.4s ease;
}

.art-card.center{
 margin-top:-30px;       /* middle card up like image */
}


.art-card img{
 width:100%;
 height:300px;
 object-fit:cover;
 filter:grayscale(20%);
}


/* TEXT */
.art-info{
 padding:16px;
 text-align:left;
}

.art-info small{
 color:#c9a227;
 letter-spacing:2px;
 font-size:11px;
}

.art-info h3{
 margin:6px 0;
 font-weight:320;
}


/* HOVER */
.art-card:hover{
 transform:translateY(-8px);
 border-color:#c9a227;
}
/* ===== PHILOSOPHY SECTION ===== */

.philo-section{
 display:flex;
 background:#0b0905;
}

/* LEFT SIDE */
.philo-left{
 width:50%;
 position:relative;
}

.philo-left img{
 width:100%;
 height:100%;
 object-fit:cover;
 filter:grayscale(40%);
}

.philo-title{
 position:absolute;
 bottom:40px;
 left:40px;
}

.philo-title small{
 color:#c9a227;
 letter-spacing:3px;
}

.philo-title h2{
 font-size:38px;
}

.philo-title span{
 color:#c9a227;
}


/* RIGHT SIDE */
.philo-right{
 width:50%;
 padding:70px 60px;
}

.philo-right .tag{
 color:#c9a227;
 letter-spacing:3px;
}

.philo-right .main{
 margin:10px 0 40px;
}


/* ITEM STYLE */
.p-item{
 display:flex;
 gap:20px;
 margin-bottom:26px;
 position:relative;
}


/* golden diamond dot */
.dot{
 width:12px;
 height:12px;
 border:1px solid #c9a227;
 transform:rotate(45deg);
 margin-top:6px;
}


.p-item h4{
 color:#c9a227;
 margin:0 0 6px;
 letter-spacing:1px;
}

.p-item p{
 opacity:.8;
 font-size:14px;
 line-height:22px;
}


/* VERTICAL LINE */
.p-item:before{
 content:'';
 position:absolute;
 left:5px;
 top:18px;

 width:1px;
 height:110%;
 background:#2a2616;
}


/* MOBILE */
@media(max-width:900px){

 .philo-section{
   flex-direction:column;
 }

 .philo-left,
 .philo-right{
   width:100%;
 }

}
/* ===== CORE PHILOSOPHY LAYOUT FIX ===== */

.philo-section{
 display:flex;
 justify-content:center;        /* CENTER WHOLE SECTION */
 align-items:center;
 gap:60px;                      /* SPACE BETWEEN IMAGE & TEXT */

 background:#0b0905;
 padding:90px 8%;               /* LEFT RIGHT SPACE LIKE IMAGE */
}


/* ===== LEFT IMAGE ===== */

.philo-left{
 width:48%;                     /* NOT FULL – LIKE IMAGE */
 position:relative;

 opacity:0;
 transform:translateX(-120px);
 transition:1.1s cubic-bezier(.16,1,.3,1);
}

.philo-left.show{
 opacity:1;
 transform:translateX(0);
}

.philo-left img{
 width:100%;
 height:520px;                  /* FIX HEIGHT LIKE REF */
 object-fit:cover;
 filter:grayscale(30%);
 border:1px solid #2a2616;
}


/* ===== RIGHT CONTENT ===== */

.philo-right{
 width:42%;                     /* SMALLER – CENTER LOOK */
}


/* ===== ITEM STYLE ===== */

.p-item{
 display:flex;
 gap:20px;
 margin-bottom:30px;
 position:relative;

 opacity:0;
 transform:translateX(140px);
 transition:.9s cubic-bezier(.16,1,.3,1);
}

.p-item.show{
 opacity:1;
 transform:translateX(0);
}


/* DELAY ONE BY ONE */
.p-item:nth-child(1).show{ transition-delay:.2s }
.p-item:nth-child(2).show{ transition-delay:.4s }
.p-item:nth-child(3).show{ transition-delay:.6s }
.p-item:nth-child(4).show{ transition-delay:.8s }
.p-item:nth-child(5).show{ transition-delay:1s }


/* GOLD DIAMOND */
.dot{
 width:12px;
 height:12px;
 border:1px solid #c9a227;
 transform:rotate(45deg);
 margin-top:6px;

 animation:glow 2s infinite;
}


/* VERTICAL LINE */
.p-item:before{
 content:'';
 position:absolute;
 left:5px;
 top:18px;

 width:1px;
 height:0;
 background:#2a2616;
 transition:1s ease;
}

.p-item.show:before{
 height:110%;
}


/* HOVER PREMIUM */
.p-item:hover h4{
 text-shadow:0 0 10px rgba(201,162,39,.7);
 letter-spacing:2px;
 transition:.4s;
}


/* DIAMOND ANIMATION */
@keyframes glow{
 0%{ box-shadow:0 0 0 0 rgba(201,162,39,.4); }
 70%{ box-shadow:0 0 0 10px rgba(201,162,39,0); }
 100%{ box-shadow:0 0 0 0 rgba(201,162,39,0); }
}


/* ===== MOBILE ===== */
@media(max-width:900px){

 .philo-section{
   flex-direction:column;
   padding:60px 20px;
 }

 .philo-left,
 .philo-right{
   width:100%;
 }

}


/* ===== ANIMATION ===== */

@keyframes fadeDown{
 from{opacity:0; transform:translateY(-40px);}
 to{opacity:1; transform:translateY(0);}
}


/* delay per block */
.block:nth-child(1).show{transition-delay:.1s}
.block:nth-child(2).show{transition-delay:.2s}
.block:nth-child(3).show{transition-delay:.3s}


/* ===== MOBILE ===== */
@media(max-width:900px){

 .block{
  flex-direction:column !important;
 }

 .block img,
 .text{
  width:100%;
 }

}

</style>
</head>

<body>


<!-- ===== HEADER ===== -->
<div class="navbar">

<!-- LOGO -->
<a href="index.jsp" class="brand">
   <img src="images/scissor.png">
   <div class="brand-text">
      Golden<span>Glow</span>
   </div>
</a>


<!-- RIGHT SIDE -->
<div class="nav-links">

  <a href="index.jsp">Home</a>

  <a href="about.jsp" class="active">About</a>

  <a href="contact.jsp">Contact</a>

  <a href="login.jsp" class="login-btn">Login</a>

  <a href="register.jsp" class="register-btn">Register</a>

</div>

</div>

<!-- ===== HERO ===== -->
<div class="hero">

 <small>PREMIUM SALON EXPERIENCE</small>

 <h1>Where Beauty Meets <span>Convenience</span></h1>

</div>
<!-- ===== STATS SECTION ===== -->
<div class="stats">

  <div class="stat">
     <h2>15</h2>
     <div class="s-line"></div>
     <p>YEARS OF MASTERY</p>
  </div>

  <div class="stat">
     <h2>10k</h2>
     <div class="s-line"></div>
     <p>GLOBAL CLIENTS</p>
  </div>

  <div class="stat">
     <h2>24</h2>
     <div class="s-line"></div>
     <p>COUTURE AWARDS</p>
  </div>

  <div class="stat">
     <h2>12</h2>
     <div class="s-line"></div>
     <p>MASTER ARTISANS</p>
  </div>

</div>


<!-- ===== HOW WE STARTED ===== -->

<h2 class="title">How We Started</h2>

<div class="timeline">


<!-- BLOCK 1 -->
<div class="block">

 <img src="images/g3.jpg">
 

 <div class="text">

  <div class="line"></div>

  <div class="year">2020</div>
  <h3>THE IDEA</h3>

  <p>
   We realized the gap in the digital market.  
   Salons were struggling with manual bookings,  
   lost records and poor customer engagement.  
   Our mission started to simplify appointments.
  </p>

 </div>

</div>


<!-- BLOCK 2 -->
<div class="block">

 <img src="images/g2.jpg">

 <div class="text">

  <div class="line"></div>

  <div class="year">2021</div>
  <h3>THE STRUGGLE</h3>

  <p>
   Transforming traditional salons into digital  
   platforms required deep research and planning.  
   We worked with real salon owners to design system.
  </p>

 </div>

</div>



<!-- BLOCK 3 -->
<div class="block">

 <img src="images/g1.jpg">

 <div class="text">

  <div class="line"></div>

  <div class="year">2022</div>
  <h3>THE SOLUTION</h3>

  <p>
   Finally we launched complete Salon Management  
   with online booking, owner dashboard,  
   service control and smart notifications.
  </p>

 </div>

</div>


</div>

<!-- ===== MASTER ARTISANS SECTION ===== -->

<div class="art-section">

   <div class="art-top">
      <small>OUR EXPERTS</small>
      <h2>Meet Our <span>Master Artisans</span></h2>
   </div>


   <div class="art-grid">

      <!-- CARD 1 -->
      <div class="art-card">
         <img src="images/men.jpg">

         <div class="art-info">
            <small>HAIR STYLIST</small>
            <h3>Rahul Sharma</h3>
         </div>
      </div>


      <!-- CARD 2 -->
      <div class="art-card center">
         <img src="images/women.jpg">

         <div class="art-info">
            <small>MAKEUP EXPERT</small>
            <h3>Priya Malhotra</h3>
         </div>
      </div>


      <!-- CARD 3 -->
      <div class="art-card">
         <img src="images/women2.jpg">

         <div class="art-info">
            <small>SKIN SPECIALIST</small>
            <h3>Anita Rao</h3>
         </div>
      </div>

   </div>

</div>

<!-- ===== CORE PHILOSOPHY SECTION START ===== -->
<div class="philo-section">

  <!-- LEFT IMAGE -->
  <div class="philo-left">
     <img src="images/philo.jpg">
     
     <div class="philo-title">
        <small>CRAFTSMANSHIP</small>
        <h2>THE ART OF <span>EXCELLENCE</span></h2>
     </div>
  </div>


  <!-- RIGHT CONTENT -->
  <div class="philo-right">

     <small class="tag">WHY LUXE SALON</small>
     <h2 class="main">OUR CORE PHILOSOPHY</h2>


     <!-- ITEM 1 -->
     <div class="p-item">
        <div class="dot"></div>

        <div>
          <h4>CERTIFIED STYLISTS</h4>
          <p>
           Award-winning artisans redefining boundaries of modern beauty.
          </p>
        </div>
     </div>


     <!-- ITEM 2 -->
     <div class="p-item">
        <div class="dot"></div>

        <div>
          <h4>HYGIENIC TOOLS</h4>
          <p>
           Absolute safety with medical-grade sterilization for every guest.
          </p>
        </div>
     </div>


     <!-- ITEM 3 -->
     <div class="p-item">
        <div class="dot"></div>

        <div>
          <h4>ONLINE BOOKING</h4>
          <p>
           Seamlessly schedule rituals through our sophisticated digital concierge.
          </p>
        </div>
     </div>


     <!-- ITEM 4 -->
     <div class="p-item">
        <div class="dot"></div>

        <div>
          <h4>PREMIUM PRODUCTS</h4>
          <p>
           Featuring elite global brands for purity and performance.
          </p>
        </div>
     </div>


     <!-- ITEM 5 -->
     <div class="p-item">
        <div class="dot"></div>

        <div>
          <h4>AFFORDABLE PRICE</h4>
          <p>
           Luxury redefined at competitive points that honor artisanal value.
          </p>
        </div>
     </div>


  </div>

</div>

<script>

/* ===== OLD TIMELINE ANIMATION (DON’T TOUCH) ===== */
const blocks = document.querySelectorAll('.block');

const observer = new IntersectionObserver((entries)=>{
 entries.forEach(entry=>{
   if(entry.isIntersecting){
     entry.target.classList.add('show');
   }
 });
},{ threshold:0.2 });

blocks.forEach(b => observer.observe(b));



/* ===== NEW CORE PHILOSOPHY ANIMATION ===== */

const section = document.querySelector('.philo-section');
const leftImg = document.querySelector('.philo-left');
const items = document.querySelectorAll('.p-item');

const phObserver = new IntersectionObserver((entries)=>{

 entries.forEach(e=>{

   if(e.isIntersecting){

     leftImg.classList.add('show');

     items.forEach(i=>{
       i.classList.add('show');
     });

   }

 });

},{ threshold:0.3 });

phObserver.observe(section);

</script>


</body>
</html>

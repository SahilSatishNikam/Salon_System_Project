<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us - Salon</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">

<style>
/* ===== STATS SECTION ANIMATED ===== */
.stats{
 display:flex;
 justify-content:space-around;
 align-items:center;

 background:#0e0c05;
 padding:70px 40px;
 text-align:center;

 opacity:0;
 transform:translateY(60px);
 transition:1s ease;
}

.stats.show{
 opacity:1;
 transform:translateY(0);
}

/* number style */
.stat h2{
 color:#c9a227;
 font-size:42px;
 margin:0;
 letter-spacing:2px;

 transition:.4s;
}

.stat:hover h2{
 text-shadow:0 0 12px rgba(201,162,39,.8);
 transform:scale(1.08);
}

.s-line{
 width:40px;
 height:1px;
 background:#c9a227;
 margin:10px auto;

 transform:scaleX(0);
 transition:.8s ease;
}

.stats.show .s-line{
 transform:scaleX(1);
}

.stat p{
 color:#aaa;
 font-size:15px;
 letter-spacing:3px;
 opacity:.8;
}
/* ===== HOVER WHOLE CARD EFFECT ===== */

.stat{
 transition:.4s ease;
 cursor:pointer;
}

/* when cursor on stat */
.stat:hover h2{
 text-shadow:
   0 0 10px rgba(201,162,39,.9),
   0 0 20px rgba(201,162,39,.5);

 transform:scale(1.12);
}

/* highlight text also */
.stat:hover p{
 color:#fff;
 letter-spacing:4px;
 text-shadow:0 0 8px rgba(255,255,255,.6);

 transition:.4s;
}

/* golden line brighter */
.stat:hover .s-line{
 background:#ffd700;
 box-shadow:0 0 10px rgba(201,162,39,.8);
 transform:scaleX(1.3);
}

/* subtle card lift */
.stat:hover{
 transform:translateY(-6px);
}

/* ===== GLOBAL ===== */
body{
 margin:0;
 font-family: "Times New Roman", Times, serif !important;
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

  padding:20px 80px;

  position:fixed;
  width:100%;
  top:0;
  left:0;

  z-index:9999;

  /* 🔥 IMPORTANT FIX */
  box-sizing:border-box;
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
  gap:30px;
}

.nav-links a{
  color:#fff;
  text-decoration:none;
  font-size:20px;
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

.brand-text{
  font-size:23px;
  font-weight:700;
  font-family:"Times New Roman", serif;
  color:#ffffff;
}

/* MAIN GLOW PART */
.brand-text span{
  color:#ffd700;

  /* THIS MATCHES YOUR PHOTO HALO */
  text-shadow:
    0 0 12px rgba(255,215,0,0.85),
    0 0 22px rgba(255,215,0,0.55),
    0 0 32px rgba(255,215,0,0.35),
    0 0 42px rgba(255,215,0,0.15);

  animation: photoGlow 4s ease-in-out infinite;
}

/* ===== PHOTO STYLE ANIMATION ===== */
@keyframes photoGlow{
  0%{
    opacity:.9;
    text-shadow:0 0 12px rgba(255,215,0,.6);
  }

  40%{
    opacity:1;
    text-shadow:
      0 0 18px rgba(255,215,0,1),
      0 0 30px rgba(255,215,0,.6),
      0 0 46px rgba(255,215,0,.3);
  }

  100%{
    opacity:.9;
    text-shadow:0 0 12px rgba(255,215,0,.6);
  }
}
/* whole brand animation on load */

.brand{
  opacity:0;
  transform:translateY(-10px);
  animation: brandEntry 1.2s ease forwards;
}

@keyframes brandEntry{
  to{
    opacity:1;
    transform:translateY(0);
  }
}
.brand-text span{
  color:#ffd700;

  text-shadow:
    0 0 12px rgba(255,215,0,0.8),
    0 0 22px rgba(255,215,0,0.5),
    0 0 32px rgba(255,215,0,0.3);

  animation: textIntro 2s ease forwards;
}

@keyframes textIntro{

  0%{
    opacity:0;
    text-shadow:none;
  }

  40%{
    opacity:1;
    text-shadow:
      0 0 16px rgba(255,215,0,1),
      0 0 28px rgba(255,215,0,.7),
      0 0 40px rgba(255,215,0,.4);
  }

  100%{
    text-shadow:
      0 0 10px rgba(255,215,0,.6),
      0 0 18px rgba(255,215,0,.35),
      0 0 26px rgba(255,215,0,.2);
  }
}
/* ===== LOGO ANNIMATION ===== */
.brand img{
  width:34px;

  animation: logoSpin 1.4s ease forwards;
}

@keyframes logoSpin{
  0%{
    transform:rotate(-60deg) scale(.8);
    opacity:0;
  }

  60%{
    transform:rotate(10deg) scale(1.05);
    opacity:1;
  }

  100%{
    transform:rotate(0) scale(1);
  }
}
/*GOLDENGLOW TEXT SHINE ON LOAD*/

.brand-text span{
  color:#ffd700;

  text-shadow:
    0 0 12px rgba(255,215,0,0.8),
    0 0 22px rgba(255,215,0,0.5),
    0 0 32px rgba(255,215,0,0.3);

  animation: textIntro 2s ease forwards;
}

@keyframes textIntro{

  0%{
    opacity:0;
    text-shadow:none;
  }

  40%{
    opacity:1;
    text-shadow:
      0 0 16px rgba(255,215,0,1),
      0 0 28px rgba(255,215,0,.7),
      0 0 40px rgba(255,215,0,.4);
  }

  100%{
    text-shadow:
      0 0 10px rgba(255,215,0,.6),
      0 0 18px rgba(255,215,0,.35),
      0 0 26px rgba(255,215,0,.2);
  }
}


/* ===== EXACT NAVBAR SECTION  END STYLE ===== */
/* ===== HERO ===== */
/* ===== HERO PREMIUM ANIMATION ===== */

.hero{
 text-align:center;
 padding:190px 0;
 position:relative;
 overflow:hidden;

 background:
   linear-gradient(rgba(0,0,0,.72), rgba(0,0,0,.72)),
   url('images/hero.jpg');

 background-size:110%;
 background-position:center;
 background-attachment:fixed;

 animation:heroZoom 6s ease forwards;
}

/* small top text */
.hero small{
 letter-spacing:4px;
 color:#c9a227;
 font-size:20px;

 opacity:0;
 transform:translateY(-20px);

 animation:reveal .9s ease forwards;
 animation-delay:.4s;
}

/* ===== HEADING WORD ANIMATION ONLY ===== */

.hero h1{
 font-size:48px;
 margin-top:10px;
}

/* split words */
.wipe span{
 opacity:0;
 display:inline-block;
}

/* white part */
.white{
 color:#fff;
 animation:slideWhite 1.4s ease forwards;
 animation-delay:.6s;
}

/* gold part */
.gold{
 color:#c9a227;
 animation:slideGold 1.8s ease forwards;
 animation-delay:1.2s;

 text-shadow:0 0 10px rgba(201,162,39,.4);
}

/* ===== ANIMATIONS ===== */

@keyframes reveal{
 to{
   opacity:1;
   transform:translateY(0);
 }
}

@keyframes slideWhite{
 from{
   opacity:0;
   transform:translateX(-60px);
 }
 to{
   opacity:1;
   transform:translateX(0);
 }
}

@keyframes slideGold{
 from{
   opacity:0;
   transform:translateX(60px);
 }
 to{
   opacity:1;
   transform:translateX(0);
 }
}

@keyframes heroZoom{
 from{ background-size:110%; }
 to{ background-size:100%; }
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
 font-size:38px;
 margin:40px 0;
 font-style:Times New Roman;
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
.text h3{
   font-family:"Times New Roman", Times, serif;
   font-weight:700;
}

.year{
   font-family:"Times New Roman", Times, serif;
}

.text p{
   font-family:"Times New Roman", Times, serif;
}

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
/* ===== YEAR + LINE STYLE LIKE IMAGE ===== */
.year-row{
  display:flex;
  align-items:center;
  gap:12px;
  margin-bottom:10px;
}

.year{
  color:#c9a227;
  font-family:"Times New Roman", Times, serif;
  letter-spacing:2px;
}

.y-line{
  flex:1;
  height:1px;
  background:rgba(201,162,39,.4);
}

/* HEADING WITH ICON */
.idea-title{
  display:flex;
  align-items:center;
  gap:8px;

  font-family:"Times New Roman", Times, serif;
  font-size:22px;
}

.idea-title .icon{
  color:#c9a227;
  font-size:22px;
}

.text h3{
 margin:8px 0;
 letter-spacing:1px;
 font-family:Times New Roman;
}
.text p{
   font-family:"Times New Roman", Times, serif !important;

   font-size:19px;
   line-height:30px;
   letter-spacing:.3px;

   opacity:.95;
}

/* ===== ARTISANS SECTION ===== */

/* Apply Times New Roman to full artisans section */
.art-section,
.art-section h2,
.art-section h3,
.art-section p,
.art-top,
.art-info{
   font-family: "Times New Roman", Times, serif !important;
}

.art-section{
 background:#0b0905;
 padding:90px 40px;
 text-align:center;
}

.art-top small{
 color:#c9a227;
 letter-spacing:4px;
 font-size:20px;  
}

.art-top h2{
 font-size:38px;              /* 👈 YOU ASKED SIZE 38 */
 margin:10px 0 50px;
}

.art-top span{
 color:#c9a227;
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

 transition:all 2.4s cubic-bezier(.16,1,.3,1);   /* 👈 SLOWER ANIMATION */
}

.art-card.center{
 margin-top:-30px;
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
 font-size:15px;
}

.art-info h3{
 margin:6px 0;
 font-weight:30;
}

/* ===== LEFT / RIGHT ARTISAN ANIMATION (SLOW) ===== */

/* initial state */
.art-card{
 opacity:0;
 transition:all 2.6s cubic-bezier(.16,1,.3,1);   /* 👈 SLOW SHOW */
 position:relative;
 overflow:hidden;
}

/* directions */
.art-card:nth-child(1){
 transform:translateX(-160px);
}

.art-card:nth-child(2){
 transform:translateY(120px);
}

.art-card:nth-child(3){
 transform:translateX(160px);
}

/* visible */
.art-card.show{
 opacity:1;
 transform:translate(0,0);
}

/* delay (a little slower steps) */
.art-card:nth-child(1).show{ transition-delay:.5s; }
.art-card:nth-child(2).show{ transition-delay:.9s; }
.art-card:nth-child(3).show{ transition-delay:1.3s; }

/* ===== HOVER PREMIUM ===== */

.art-card:hover{
 transform:translateY(-10px) scale(1.02) !important;
 border-color:#c9a227;
 box-shadow:
   0 10px 30px rgba(0,0,0,.6),
   0 0 12px rgba(201,162,39,.4);
}

/* image zoom */
.art-card img{
 transition:.8s;                /* 👈 slower zoom */
}

.art-card:hover img{
 transform:scale(1.06);
}

/* text glow */
.art-card:hover .art-info h3{
 text-shadow:0 0 10px rgba(255,255,255,.6);
}

.art-card:hover .art-info small{
 letter-spacing:3px;
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
font-size: 16px !important;  
 color:#c9a227;
 letter-spacing:3px;
}

.philo-right .main{
 margin:10px 0 40px;
 font-size: 32px !important;   
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
 font-size:17px;
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
/* ===== ARTISANS SECTION END===== */
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
/* ===== TESTIMONIAL SECTION ===== */
/* ===== ULTRA TESTIMONIAL ===== */

.ultra-test{
 padding:100px 20px;
 background:#0b0905;
 text-align:center;
 overflow:hidden;
}


/* TITLE */
.u-top small{
 color:#c9a227;
 letter-spacing:4px;
}

.u-top h2{
 font-size:38px;
 margin:10px 0 40px;
}

.u-top span{
 color:#c9a227;

}


/* SLIDER BASE */
.slider{
 width:100%;
 overflow:hidden;
 position:relative;
}


.slide-track{
 display:flex;
 gap:30px;

 animation:scroll 26s linear infinite;
}


/* ===== CARD MAIN (FIXED FOR IMAGE NOT CUT) ===== */

.u-card{
 width:340px;
 min-width:340px;

 /* dark luxury base */
 background:linear-gradient(
   120deg,
   #0f0d05,
   #1a1508,
   #0f0d05
 );

 border:1px solid #2a2616;
 border-radius:18px;

 /* IMPORTANT FIXES */
 padding:60px 20px 26px 20px;   /* top space for image */
 text-align:center;

 position:relative;
 z-index:1;

 transition:.5s;
}



/* ===== GOLD SWEEP LAYER (SOFT + SLOW) ===== */

.u-card::before{
 content:'';

 position:absolute;
 top:0;
 left:-140%;

 width:70%;
 height:100%;

 background:linear-gradient(
   90deg,
   transparent,
   rgba(255,215,0,.12),   /* very faint */
   rgba(255,215,0,.22),   /* peak soft */
   rgba(255,215,0,.12),
   transparent
 );

 transform:skewX(-18deg);

 animation:goldSweep 4.5s ease-in-out infinite;   /* slow elegant */
}


/* keep content above light */
.u-card *{
 position:relative;
 z-index:2;
}


/* CLIENT IMAGE */
.client{
 width:84px;
 height:84px;
 border-radius:50%;

 object-fit:cover;

 border:2px solid #c9a227;
 margin-top:-60px;

 background:#000;
}


/* ===== STARS (SOFTER) ===== */

.stars{
 color:#ffd700;
 margin:10px 0;
 letter-spacing:3px;

 text-shadow:
   0 0 6px rgba(255,215,0,.5),
   0 0 12px rgba(255,215,0,.2);

 animation:pulse 3s infinite;
}


/* ===== TEXT VISIBILITY ===== */

.u-card p{
 font-size:15px;
 line-height:24px;

 color:#e6e6e6;
 letter-spacing:.4px;

 margin:10px 0;
}

.u-card h4{
 color:#ffd700;
 font-weight:600;
 margin:10px 0 2px;
}

.u-card small{
 color:#aaa;
}


/* ===== HOVER PREMIUM ===== */

 .u-card:hover{
   transform:translateY(-4px);   /* 🔥 SAFE */
}
 

 box-shadow:
   0 10px 40px rgba(0,0,0,.8),
   0 0 20px rgba(201,162,39,.5);

 border-color:#c9a227;
}


/* PAUSE ON HOVER */
.slider:hover .slide-track{
 animation-play-state:paused;
}


/* ===== ANIMATIONS ===== */

@keyframes scroll{
 0%{ transform:translateX(0); }
 100%{ transform:translateX(-50%); }
}


/* GOLD SWEEP – SOFT CINEMATIC */
@keyframes goldSweep{

 0%{
   left:-140%;
   opacity:.6;
 }

 50%{
   opacity:1;
 }

 100%{
   left:140%;
   opacity:.6;
 }

}


/* STAR PULSE */
@keyframes pulse{
 0%{ transform:scale(1); }
 50%{ transform:scale(1.06); }
 100%{ transform:scale(1); }
}


/* MOBILE */
@media(max-width:900px){

 .u-card{
   width:300px;
   min-width:300px;
 }

}

/* ===== FOOTER ===== */

.footer{
 background:#0e0c05;
 padding:80px 40px 20px;
 margin-top:80px;

 opacity:0;
 transform:translateY(80px);
 transition:1s ease;
}

/* show on scroll */
.footer.show{
 opacity:1;
 transform:translateY(0);
}


.f-container{
 display:grid;
 grid-template-columns:repeat(auto-fit, minmax(220px,1fr));
 gap:30px;
}


.f-box h3{
 color:#ffd700;
 margin-bottom:10px;
}

.f-box h4{
 color:#c9a227;
 margin-bottom:12px;
}


/* links */
.f-box a{
 display:block;
 color:#aaa;
 text-decoration:none;
 margin:6px 0;

 transition:.3s;
}

.f-box a:hover{
 color:#fff;
 letter-spacing:1px;
}


/* text */
.f-box p{
 color:#aaa;
 font-size:14px;
 line-height:22px;
}
.f-box h3{
 font-size:22px;
 font-weight:700;
}

/* Golden part */
.f-box h3 span{
 color:#ffd700;        /* same gold as your header */
}

/* White part */
.f-box h3{
 color:#ffffff;
}
.f-box h3 span{
 color:#ffd700;

 text-shadow:
   0 0 6px rgba(255,215,0,.6),
   0 0 12px rgba(255,215,0,.3);
}



/* social */
.social span{
 display:inline-block;
 margin-right:10px;

 color:#aaa;
 cursor:pointer;

 transition:.3s;
}

.social span:hover{
 color:#ffd700;
 transform:translateY(-3px);
}


/* bottom line */
.copy{
 text-align:center;
 margin-top:40px;

 color:#666;
 font-size:13px;

 border-top:1px solid #1e1b10;
 padding-top:16px;
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

 <h1 class="wipe">
   <span class="white">Where Beauty Meets</span>
   <span class="gold">Convenience</span>
</h1>


 <div class="hero-line"></div>

</div>

<!-- ===== STATS SECTION ===== -->
<div class="stats">

  <div class="stat">
     <h2 data-count="15">0</h2>
     <div class="s-line"></div>
     <p>YEARS OF MASTERY</p>
  </div>

  <div class="stat">
     <h2 data-count="10000">0</h2>
     <div class="s-line"></div>
     <p>GLOBAL CLIENTS</p>
  </div>

  <div class="stat">
     <h2 data-count="24">0</h2>
     <div class="s-line"></div>
     <p>COUTURE AWARDS</p>
  </div>

  <div class="stat">
     <h2 data-count="12">0</h2>
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

  <div class="year-row">
   <span class="year">2022</span>
   <div class="y-line"></div>
</div>

<h3 class="idea-title">
   <span class="material-icons icon">emoji_objects</span>
   THE IDEA
</h3>
  

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

 

 <div class="year-row">
   <span class="year">2023</span>
   <div class="y-line"></div>
</div>

<h3 class="idea-title">
   <span class="material-icons icon">auto_awesome
</span>
   THE RESEARCH
</h3>
  

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


  <div class="year-row">
   <span class="year">2024</span>
   <div class="y-line"></div>
</div>

<h3 class="idea-title">
   <span class="material-icons icon">emoji_events</span>
   THE SOLUTION
</h3>

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
         <img src="images/w1.jpeg">

         <div class="art-info">
            <small>MAKEUP EXPERT</small>
            <h3>Priya Malhotra</h3>
         </div>
      </div>


      <!-- CARD 3 -->
      <div class="art-card">
         <img src="images/w2.jpeg">

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

     <small class="tag">WHY GOLDENGLOW SALON</small>
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
<!-- ===== TESTIMONIAL SECTION ===== -->

<!-- ===== ULTRA TESTIMONIAL SECTION ===== -->

<div class="ultra-test">

 <div class="u-top">
   <small>TRUSTED BY CLIENTS</small>
   <h2>Luxury Experience <span>Real Stories</span></h2>
 </div>


 <div class="slider">

   <div class="slide-track">

     <!-- ===== ITEM 1 ===== -->
     <div class="u-card">

       <img src="images/c1.jpeg" class="client">

       <div class="stars">
         ★★★★★
       </div>

       <p>
        Best salon experience ever.  
        Staff behavior, hygiene and result  
        everything is just perfect.
       </p>

       <h4>Priya Sharma</h4>
       <small>Hair Smoothening</small>

     </div>


     <!-- ===== ITEM 2 ===== -->
     <div class="u-card">

       <img src="images/c2.jpeg" class="client">

       <div class="stars">
         ★★★★☆
       </div>

       <p>
        My bridal makeup was stunning.  
        I received compliments whole day.  
        Highly professional team.
       </p>

       <h4>Sneha Patil</h4>
       <small>Bridal Makeup</small>

     </div>



     <!-- ===== ITEM 3 ===== -->
     <div class="u-card">

       <img src="images/men.jpg" class="client">

       <div class="stars">
         ★★★★★
       </div>

       <p>
        Facial result was glowing for weeks.  
        Products are genuine and staff is  
        very knowledgeable.
       </p>

       <h4>Arav Patil</h4>
       <small>facials</small>

     </div>



     <!-- ===== DUPLICATE FOR INFINITE LOOP ===== -->
      <!-- ===== ITEM 3 ===== -->
     <div class="u-card">

       <img src="images/c3.jpg" class="client">

       <div class="stars">
         ★★★★★
       </div>

       <p>
        My haircut looked perfect for weeks.
        The staff is skilled
        and uses genuine products.”
       </p>

       <h4>Arti Khurana</h4>
       <small>haircuts</small>

     </div>
     
       <!-- ===== ITEM 3 ===== -->
     <div class="u-card">

       <img src="images/men.jpg" class="client">

       <div class="stars">
         ★★★★★
       </div>

       <p>
        Facial result was glowing for weeks.  
        Products are genuine and staff is  
        very knowledgeable.
       </p>

       <h4>Rohan Mehta</h4>
       <small>Skin Treatment</small>

     </div>
       <!-- ===== ITEM 3 ===== -->
     <div class="u-card">

       <img src="images/c3.jpeg" class="client">

       <div class="stars">
         ★★★★★
       </div>

       <p>
       My haircut looked perfect for weeks.
The staff is skilled, professional, and uses genuine products.
       </p>

       <h4>Arti Khurana</h4>
       <small>haircuts</small>

     </div>


   </div>

 </div>

</div>
<!-- ===== FOOTER ===== -->
<footer class="footer">

  <div class="f-container">

    <!-- COL 1 -->
    <div class="f-box">
    <h3>Golden<span>Glow</span></h3>


      <p>
        Premium salon experience with  
        expert stylists and luxury care.
      </p>
    </div>


    <!-- COL 2 -->
    <div class="f-box">
      <h4>Quick Links</h4>

      <a href="index.jsp">Home</a>
      <a href="about.jsp">About</a>
      <a href="contact.jsp">Contact</a>
      <a href="login.jsp">Login</a>
    </div>


    <!-- COL 3 -->
    <div class="f-box">
      <h4>Contact</h4>

      <p>📍 Mumbai, India</p>
      <p>📞 +91 98765 43210</p>
      <p>✉ salon@gmail.com</p>
    </div>


    <!-- COL 4 -->
    <div class="f-box">
      <h4>Follow Us</h4>

      <div class="social">
        <span>Instagram</span>
        <span>Facebook</span>
        <span>Twitter</span>
      </div>
    </div>

  </div>


  <div class="copy">
     © 2025 GoldenGlow. All Rights Reserved.
  </div>

</footer>


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


/* ===== STATS COUNT ANIMATION ===== */

const statsSection = document.querySelector('.stats');
const counters = document.querySelectorAll('.stat h2');

function startCount(){

  counters.forEach(counter => {

    const target = +counter.getAttribute('data-count');

    let count = 0;

    const speed = target / 100;   // smaller = slower

    const update = () => {

      count += speed;

      if(count < target){
        counter.innerText = Math.floor(count);
        requestAnimationFrame(update);
      }
      else{

        // format 10k style
        if(target >= 1000){
          counter.innerText = (target/1000) + "k";
        }else{
          counter.innerText = target;
        }

      }

    };

    update();

  });

}


/* observer */
const statObserver = new IntersectionObserver((entries)=>{

 entries.forEach(e=>{

   if(e.isIntersecting){

     statsSection.classList.add('show');

     startCount();

   }

 });

},{ threshold:0.3 });

statObserver.observe(statsSection);

/* ===== ARTISAN CARD ANIMATION ===== */

const cards = document.querySelectorAll('.art-card');

const cardObserver = new IntersectionObserver((entries)=>{

  entries.forEach(entry=>{

    if(entry.isIntersecting){
      entry.target.classList.add('show');
    }

  });

},{ threshold:0.25 });

cards.forEach(c => cardObserver.observe(c));

/* ===== TESTIMONIAL ANIMATION ===== */

const testCards = document.querySelectorAll('.test-card');

const testObserver = new IntersectionObserver((entries)=>{

 entries.forEach(entry=>{

   if(entry.isIntersecting){
     entry.target.classList.add('show');
   }

 });

},{ threshold:0.25 });

testCards.forEach(c => testObserver.observe(c));

/* ===== FOOTER ANIMATION ===== */

const footer = document.querySelector('.footer');

const footObs = new IntersectionObserver((e)=>{

  e.forEach(x=>{
    if(x.isIntersecting){
      footer.classList.add('show');
    }
  });

},{ threshold:0.2 });

footObs.observe(footer);



</script>


</body>
</html>

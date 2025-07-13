<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>hhuseyinzeybek 💪🏻</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow: hidden;
      font-family: 'Segoe UI', sans-serif;
      height: 100vh;
    }

    #intro {
      position: absolute;
      z-index: 10;
      width: 100%;
      height: 100%;
      background: #001f3f;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      color: white;
    }

    #startBtn {
      padding: 20px 40px;
      font-size: 1.5em;
      background: #ffd700;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      box-shadow: 0 0 15px #fff;
      transition: transform 0.3s ease;
      z-index: 11;
    }

    #startBtn:hover {
      transform: scale(1.05);
    }

    .door {
      position: absolute;
      top: 0;
      width: 50%;
      height: 100%;
      background-color: #001f3f;
      z-index: 9;
      transition: all 1.5s ease;
    }

    .left-door {
      left: 0;
    }

    .right-door {
      right: 0;
    }

    .open-left {
      transform: translateX(-100%);
    }

    .open-right {
      transform: translateX(100%);
    }

    #mainContent {
      position: absolute;
      width: 100%;
      height: 100%;
      background: linear-gradient(to top right, #001f3f, #004080);
      color: white;
      display: none;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      text-align: center;
      z-index: 1;
    }

    h1 {
      font-size: 4em;
      animation: glow 2s ease-in-out infinite alternate;
      text-shadow: 0 0 10px #fff, 0 0 20px #ffe066, 0 0 30px #ffd700;
      margin: 0;
    }

    .moon {
      font-size: 3em;
      animation: pulse 3s infinite;
      margin-bottom: 20px;
    }

    p {
      font-size: 1.5em;
      color: #fffae6;
      margin-top: 20px;
    }

    @keyframes glow {
      from { text-shadow: 0 0 5px #fff, 0 0 10px #ffd700; }
      to { text-shadow: 0 0 20px #fff, 0 0 40px #ffe066; }
    }

    @keyframes pulse {
      0% { transform: scale(1); opacity: 0.8; }
      50% { transform: scale(1.2); opacity: 1; }
      100% { transform: scale(1); opacity: 0.8; }
    }

    canvas {
      position: fixed;
      top: 0;
      left: 0;
      pointer-events: none;
      z-index: 12;
    }

    .star {
      position: absolute;
      color: #fffacd;
      animation: twinkle 3s infinite;
      font-size: 1em;
      pointer-events: none;
    }

    @keyframes twinkle {
      0%, 100% { opacity: 0.3; transform: scale(1); }
      50% { opacity: 1; transform: scale(1.5); }
    }
  </style>
</head>
<body>

  <!-- Giriş ekranı -->
  <div id="intro">
    <button id="startBtn">🎉 Hazır mısın?
  </div>

  <!-- Kapılar -->
  <div class="door left-door" id="leftDoor"></div>
  <div class="door right-door" id="rightDoor"></div>

  <!-- Konfeti Canvas -->
  <canvas id="confetti"></canvas>

  <!-- Ana içerik -->
  <div id="mainContent">
    <div class="moon">💪🏻</div>
    <h1>hhuseyinzeybek
    <p>Sende bu tarz tasarım istermisin? ⚡️
  </div>

  <!-- Ses -->
  <audio id="sound" src="acilis.mp3" preload="auto"></audio>

  <script>
    const startBtn = document.getElementById("startBtn");
    const intro = document.getElementById("intro");
    const leftDoor = document.getElementById("leftDoor");
    const rightDoor = document.getElementById("rightDoor");
    const mainContent = document.getElementById("mainContent");
    const sound = document.getElementById("sound");

    // Konfeti setup
    const canvas = document.getElementById('confetti');
    const ctx = canvas.getContext('2d');
    let confettis = [];

    function resizeCanvas() {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    }

    function createConfetti() {
      for (let i = 0; i < 150; i++) {
        confettis.push({
          x: Math.random() * canvas.width,
          y: Math.random() * canvas.height - canvas.height,
          r: Math.random() * 6 + 2,
          d: Math.random() * 5 + 1,
          color: `hsl(${Math.random() * 360}, 100%, 60%)`
        });
      }
    }

    function drawConfetti() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      confettis.forEach(c => {
        ctx.beginPath();
        ctx.arc(c.x, c.y, c.r, 0, Math.PI * 2);
        ctx.fillStyle = c.color;
        ctx.fill();
      });
      updateConfetti();
      requestAnimationFrame(drawConfetti);
    }

    function updateConfetti() {
      confettis.forEach(c => {
        c.y += c.d;
        c.x += Math.sin(c.y * 0.01);
        if (c.y > canvas.height) {
          c.y = -10;
          c.x = Math.random() * canvas.width;
        }
      });
    }

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    startBtn.addEventListener("click", () => {
      sound.play();
      createConfetti();
      drawConfetti();

      leftDoor.classList.add("open-left");
      rightDoor.classList.add("open-right");
      intro.style.display = "none";

      setTimeout(() => {
        mainContent.style.display = "flex";
      }, 1500);
    });

    // Arka plan yıldızlar
    function createStar() {
      const star = document.createElement("div");
      star.classList.add("star");
      star.innerText = "✨";
      star.style.top = Math.random() * 100 + "vh";
      star.style.left = Math.random() * 100 + "vw";
      star.style.fontSize = (Math.random() * 1 + 0.5) + "em";
      star.style.animationDuration = (Math.random() * 2 + 2) + "s";
      document.body.appendChild(star);
      setTimeout(() => star.remove(), 4000);
    }

    setInterval(createStar, 400);
  </script>

</body>
</html>
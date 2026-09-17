/* =========================================================
   DYNAMIC PERSONAL PORTFOLIO — JAYDEEP VERMA
   Fresher / Entry-Level Software Engineer & B.Tech CSE Undergraduate
   Interactive JavaScript: Real Email Dispatch (FormSubmit),
   Theme Switcher, Particle Engine, Typewriter, Live Filter & Copy Toasts
   ========================================================= */

document.addEventListener('DOMContentLoaded', () => {

  /* ===== 1. THEME SWITCHER (LIGHT / DARK MODE) ===== */
  const themeToggleBtns = document.querySelectorAll('.theme-toggle-btn, .corner-theme-toggle');
  const currentTheme = localStorage.getItem('jv_portfolio_theme') || 'dark';

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('jv_portfolio_theme', theme);

    themeToggleBtns.forEach(btn => {
      const icon = btn.querySelector('i');
      if (icon) {
        if (theme === 'light') {
          icon.className = 'fa-solid fa-moon';
          btn.setAttribute('title', 'Switch to Dark Mode');
        } else {
          icon.className = 'fa-solid fa-sun';
          btn.setAttribute('title', 'Switch to Light Mode');
        }
      }
    });
  }

  // Initialize theme
  applyTheme(currentTheme);

  themeToggleBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const activeTheme = document.documentElement.getAttribute('data-theme') || 'dark';
      const newTheme = activeTheme === 'dark' ? 'light' : 'dark';
      applyTheme(newTheme);
      showToast(newTheme === 'light' ? '☀️ Switched to Light Mode' : '🌙 Switched to Dark Mode');
    });
  });

  /* ===== 2. PRELOADER ===== */
  window.addEventListener('load', () => {
    setTimeout(() => {
      const loader = document.getElementById('loader');
      if (loader) {
        loader.classList.add('hidden');
        setTimeout(() => loader.remove(), 500);
      }
    }, 450);
  });

  setTimeout(() => {
    const loader = document.getElementById('loader');
    if (loader && !loader.classList.contains('hidden')) {
      loader.classList.add('hidden');
      setTimeout(() => loader.remove(), 500);
    }
  }, 1400);

  /* ===== 3. CUSTOM CURSOR ===== */
  const dot = document.getElementById('cursor-dot');
  const ring = document.getElementById('cursor-ring');
  let mouseX = window.innerWidth / 2;
  let mouseY = window.innerHeight / 2;
  let ringX = mouseX;
  let ringY = mouseY;
  const isTouchDevice = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0);

  if (!isTouchDevice && dot && ring) {
    document.addEventListener('mousemove', e => {
      mouseX = e.clientX;
      mouseY = e.clientY;
    });

    function animateCursor() {
      dot.style.left = mouseX + 'px';
      dot.style.top = mouseY + 'px';

      ringX += (mouseX - ringX) * 0.15;
      ringY += (mouseY - ringY) * 0.15;
      ring.style.left = ringX + 'px';
      ring.style.top = ringY + 'px';

      requestAnimationFrame(animateCursor);
    }
    animateCursor();

    const interactiveSelectors = 'a, button, .filter-btn, .skill-chip, .soft-skill-card, .project-card, .achievement-card, .contact-item, input, textarea';
    document.querySelectorAll(interactiveSelectors).forEach(el => {
      el.addEventListener('mouseenter', () => {
        ring.style.width = '44px';
        ring.style.height = '44px';
        ring.style.borderColor = 'rgba(192, 132, 252, 0.9)';
        ring.style.backgroundColor = 'rgba(168, 85, 247, 0.08)';
      });
      el.addEventListener('mouseleave', () => {
        ring.style.width = '34px';
        ring.style.height = '34px';
        ring.style.borderColor = 'rgba(168, 85, 247, 0.6)';
        ring.style.backgroundColor = 'transparent';
      });
    });
  } else if (dot && ring) {
    dot.style.display = 'none';
    ring.style.display = 'none';
  }

  /* ===== 4. NAVBAR SCROLL & ACTIVE SCROLLSPY ===== */
  const nav = document.querySelector('nav');
  const navLinks = document.querySelectorAll('.nav-links a');
  const sections = document.querySelectorAll('section, header');

  function handleNavScroll() {
    if (nav) {
      nav.classList.toggle('scrolled', window.scrollY > 40);
    }

    let currentSectionId = '';
    const scrollPos = window.scrollY + 120;

    sections.forEach(sec => {
      const top = sec.offsetTop;
      const height = sec.offsetHeight;
      if (scrollPos >= top && scrollPos < top + height) {
        currentSectionId = sec.getAttribute('id');
      }
    });

    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${currentSectionId}`) {
        link.classList.add('active');
      }
    });
  }

  window.addEventListener('scroll', handleNavScroll, { passive: true });
  handleNavScroll();

  /* ===== 5. HAMBURGER MENU ===== */
  const hamburger = document.querySelector('.hamburger');
  const navLinksList = document.querySelector('.nav-links');

  if (hamburger && navLinksList) {
    hamburger.addEventListener('click', () => {
      hamburger.classList.toggle('open');
      navLinksList.classList.toggle('open');
    });

    navLinksList.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        hamburger.classList.remove('open');
        navLinksList.classList.remove('open');
      });
    });
  }

  /* ===== 6. PARTICLE CANVAS ===== */
  (function initParticles() {
    const canvas = document.getElementById('particle-canvas');
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    let W, H, particles = [];
    const NUM = Math.min(60, Math.floor(window.innerWidth / 20));
    const MAX_DIST = 120;

    function resize() {
      W = canvas.width = window.innerWidth;
      H = canvas.height = window.innerHeight;
    }
    resize();
    window.addEventListener('resize', resize);

    const colors = [
      'rgba(168, 85, 247, ',
      'rgba(99, 102, 241, ',
      'rgba(236, 72, 153, ',
      'rgba(192, 132, 252, '
    ];

    class Particle {
      constructor() {
        this.reset();
      }
      reset() {
        this.x = Math.random() * W;
        this.y = Math.random() * H;
        this.vx = (Math.random() - 0.5) * 0.45;
        this.vy = (Math.random() - 0.5) * 0.45;
        this.r = Math.random() * 1.8 + 1;
        this.colorBase = colors[Math.floor(Math.random() * colors.length)];
        this.alpha = Math.random() * 0.45 + 0.2;
      }
      update() {
        this.x += this.vx;
        this.y += this.vy;
        if (this.x < 0 || this.x > W) this.vx *= -1;
        if (this.y < 0 || this.y > H) this.vy *= -1;
      }
      draw() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2);
        ctx.fillStyle = this.colorBase + this.alpha + ')';
        ctx.fill();
      }
    }

    for (let i = 0; i < NUM; i++) {
      particles.push(new Particle());
    }

    function animate() {
      ctx.clearRect(0, 0, W, H);
      for (let i = 0; i < particles.length; i++) {
        particles[i].update();
        particles[i].draw();

        for (let j = i + 1; j < particles.length; j++) {
          const dx = particles[i].x - particles[j].x;
          const dy = particles[i].y - particles[j].y;
          const dist = Math.sqrt(dx * dx + dy * dy);

          if (dist < MAX_DIST) {
            const alpha = (1 - dist / MAX_DIST) * 0.16;
            ctx.beginPath();
            ctx.moveTo(particles[i].x, particles[i].y);
            ctx.lineTo(particles[j].x, particles[j].y);
            ctx.strokeStyle = `rgba(168, 85, 247, ${alpha})`;
            ctx.lineWidth = 0.7;
            ctx.stroke();
          }
        }
      }
      requestAnimationFrame(animate);
    }
    animate();
  })();

  /* ===== 7. TYPEWRITER EFFECT ===== */
  const typewriterElement = document.querySelector('.typewriter-text');
  const roles = [
    'Computer Science & Engineering Student',
    'Aspiring Software Engineer & Developer',
    'Full-Stack Developer (React & Node.js)',
    'IoT Telemetry & Embedded Systems Lead',
    'Smart India Hackathon (SIH) Participant'
  ];

  let roleIndex = 0;
  let charIndex = 0;
  let isDeleting = false;
  let typeSpeed = 75;

  function typeWriter() {
    if (!typewriterElement) return;
    const currentRole = roles[roleIndex];

    if (isDeleting) {
      typewriterElement.textContent = currentRole.substring(0, charIndex - 1);
      charIndex--;
      typeSpeed = 30;
    } else {
      typewriterElement.textContent = currentRole.substring(0, charIndex + 1);
      charIndex++;
      typeSpeed = 80;
    }

    if (!isDeleting && charIndex === currentRole.length) {
      typeSpeed = 2200;
      isDeleting = true;
    } else if (isDeleting && charIndex === 0) {
      isDeleting = false;
      roleIndex = (roleIndex + 1) % roles.length;
      typeSpeed = 400;
    }

    setTimeout(typeWriter, typeSpeed);
  }
  typeWriter();

  /* ===== 8. SCROLL REVEAL ANIMATIONS ===== */
  const revealElements = document.querySelectorAll('.reveal');
  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('active');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  revealElements.forEach(el => observer.observe(el));

  /* ===== 9. PROJECTS FILTER & SEARCH ===== */
  const filterBtns = document.querySelectorAll('.filter-btn');
  const projectCards = document.querySelectorAll('.project-card');
  const searchInput = document.querySelector('.search-box');

  function filterProjects() {
    const activeBtn = document.querySelector('.filter-btn.active');
    const selectedCategory = activeBtn ? activeBtn.getAttribute('data-filter') : 'all';
    const searchQuery = searchInput ? searchInput.value.toLowerCase().trim() : '';

    projectCards.forEach(card => {
      const cardCategory = card.getAttribute('data-category') || '';
      const title = (card.querySelector('.project-title')?.textContent || '').toLowerCase();
      const desc = (card.querySelector('.project-desc')?.textContent || '').toLowerCase();
      const tags = (card.querySelector('.tech-tags')?.textContent || '').toLowerCase();

      const matchesCategory = (selectedCategory === 'all' || cardCategory.includes(selectedCategory));
      const matchesSearch = !searchQuery || title.includes(searchQuery) || desc.includes(searchQuery) || tags.includes(searchQuery);

      if (matchesCategory && matchesSearch) {
        card.style.display = 'flex';
      } else {
        card.style.display = 'none';
      }
    });
  }

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      filterProjects();
    });
  });

  if (searchInput) {
    searchInput.addEventListener('input', filterProjects);
  }

  /* ===== 10. TOAST NOTIFICATION UTILITY ===== */
  const toast = document.getElementById('toast');

  function showToast(message, isError = false) {
    if (!toast) return;
    toast.textContent = message;
    toast.className = 'toast show' + (isError ? ' error' : '');
    setTimeout(() => {
      toast.classList.remove('show');
    }, 3600);
  }

  /* ===== 11. CLICK-TO-COPY CONTACT INFO (WITH MASKED UI) ===== */
  document.querySelectorAll('.copyable').forEach(item => {
    item.addEventListener('click', () => {
      const copyText = item.getAttribute('data-copy');
      const label = item.getAttribute('data-type') || 'Contact details';
      if (copyText) {
        navigator.clipboard.writeText(copyText).then(() => {
          showToast(`✓ Copied ${label} to clipboard!`);
        }).catch(() => {
          showToast(`Failed to copy to clipboard`, true);
        });
      }
    });
  });

  /* ===== 12. REAL EMAIL DISPATCH (FormSubmit.co API + Mailto Fallback) ===== */
  const contactForm = document.getElementById('contact-form');
  const submitBtn = contactForm ? contactForm.querySelector('button[type="submit"]') : null;

  if (contactForm) {
    contactForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      let isValid = true;

      const nameInput = document.getElementById('name');
      const emailInput = document.getElementById('email');
      const subjectInput = document.getElementById('subject');
      const messageInput = document.getElementById('message');

      [nameInput, emailInput, messageInput].forEach(input => {
        if (input) {
          const group = input.closest('.form-group');
          if (!input.value.trim()) {
            group?.classList.add('has-error');
            isValid = false;
          } else {
            group?.classList.remove('has-error');
          }
        }
      });

      if (emailInput && emailInput.value.trim()) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const group = emailInput.closest('.form-group');
        if (!emailRegex.test(emailInput.value.trim())) {
          group?.classList.add('has-error');
          isValid = false;
        }
      }

      if (!isValid) {
        showToast('⚠️ Please fill out all required fields correctly.', true);
        return;
      }

      const senderName = nameInput.value.trim();
      const senderEmail = emailInput.value.trim();
      const subjectText = subjectInput && subjectInput.value.trim() ? subjectInput.value.trim() : 'Portfolio Contact Message';
      const messageText = messageInput.value.trim();

      const originalBtnHtml = submitBtn ? submitBtn.innerHTML : 'Send Message';
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Sending message...';
      }

      try {
        const payload = {
          name: senderName,
          email: senderEmail,
          subject: subjectText,
          message: messageText,
          _subject: `New Portfolio Message from ${senderName}: ${subjectText}`,
          _template: 'table',
          _captcha: 'false'
        };

        const response = await fetch('https://formsubmit.co/ajax/jaydeepverma.jsr@gmail.com', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(payload)
        });

        if (response.ok) {
          showToast(`🎉 Message delivered directly to Jaydeep's inbox!`);
          contactForm.reset();
        } else {
          throw new Error('Server returned ' + response.status);
        }
      } catch (err) {
        console.warn('FormSubmit AJAX fallback triggered:', err);
        const mailtoUrl = `mailto:jaydeepverma.jsr@gmail.com?subject=${encodeURIComponent(subjectText)}&body=${encodeURIComponent("Name: " + senderName + "\nEmail: " + senderEmail + "\n\n" + messageText)}`;
        window.open(mailtoUrl, '_blank');
        showToast('✉️ Opening mail app to send directly...');
      } finally {
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerHTML = originalBtnHtml;
        }
      }
    });
  }

});

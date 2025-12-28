// 导航切换功能
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.section');
    const hamburger = document.querySelector('.hamburger');
    const navMenu = document.querySelector('.nav-menu');

    // 停止视频播放的函数
    function stopVideo() {
        const bilibiliIframe = document.querySelector('.bilibili-iframe');
        if (bilibiliIframe) {
            try {
                // Bilibili 播放器暂停命令
                // 方法1: 使用 postMessage 发送暂停命令
                bilibiliIframe.contentWindow.postMessage(JSON.stringify({
                    event: 'command',
                    func: 'pauseVideo',
                    args: ''
                }), '*');
                
                // 方法2: 重新加载 iframe（更可靠的方法）
                const currentSrc = bilibiliIframe.src;
                bilibiliIframe.src = '';
                setTimeout(() => {
                    bilibiliIframe.src = currentSrc;
                }, 100);
            } catch (e) {
                // 如果跨域限制，尝试重新加载 iframe
                try {
                    const currentSrc = bilibiliIframe.src;
                    bilibiliIframe.src = '';
                    setTimeout(() => {
                        bilibiliIframe.src = currentSrc;
                    }, 100);
                } catch (err) {
                    console.log('无法停止视频播放:', err);
                }
            }
        }
        
        // 如果使用原生 video 标签
        const videoElement = document.querySelector('.product-video');
        if (videoElement) {
            videoElement.pause();
            videoElement.currentTime = 0; // 重置到开头
        }
    }

    // 导航链接点击事件
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // 停止视频播放
            stopVideo();
            
            // 移除所有活动状态
            navLinks.forEach(l => l.classList.remove('active'));
            sections.forEach(s => s.classList.remove('active'));
            
            // 添加当前活动状态
            this.classList.add('active');
            const targetSection = this.getAttribute('data-section');
            const section = document.getElementById(targetSection);
            
            if (section) {
                section.classList.add('active');
                
                // 平滑滚动到顶部
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }
            
            // 移动端关闭菜单
            if (window.innerWidth <= 768) {
                navMenu.classList.remove('active');
            }
        });
    });

    // 汉堡菜单切换
    if (hamburger) {
        hamburger.addEventListener('click', function() {
            navMenu.classList.toggle('active');
        });
    }

    // 点击外部关闭移动端菜单
    document.addEventListener('click', function(e) {
        if (window.innerWidth <= 768) {
            if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
                navMenu.classList.remove('active');
            }
        }
    });

    // 窗口大小改变时关闭移动端菜单
    window.addEventListener('resize', function() {
        if (window.innerWidth > 768) {
            navMenu.classList.remove('active');
        }
    });

    // 监听板块切换，自动停止视频
    const sectionObserver = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
                const target = mutation.target;
                // 如果视频板块被隐藏（失去 active 类）
                if (target.id === 'video' && !target.classList.contains('active')) {
                    stopVideo();
                }
            }
        });
    });

    // 观察所有板块的变化
    sections.forEach(section => {
        sectionObserver.observe(section, {
            attributes: true,
            attributeFilter: ['class']
        });
    });

    // 视频占位符点击事件（可以后续添加视频播放功能）
    const videoPlaceholder = document.querySelector('.video-placeholder');
    if (videoPlaceholder) {
        videoPlaceholder.addEventListener('click', function() {
            // 这里可以添加视频播放逻辑
            console.log('视频播放区域被点击');
        });
    }

    // 添加滚动动画效果
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // 观察所有卡片元素
    const cards = document.querySelectorAll('.feature-card, .team-card, .info-item');
    cards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
});

// 添加鼠标跟随效果（可选，增强科技感）
document.addEventListener('mousemove', function(e) {
    const cursor = document.querySelector('.cursor');
    if (!cursor) {
        const newCursor = document.createElement('div');
        newCursor.className = 'cursor';
        newCursor.style.cssText = `
            width: 20px;
            height: 20px;
            border: 2px solid rgba(0, 212, 255, 0.5);
            border-radius: 50%;
            position: fixed;
            pointer-events: none;
            z-index: 9999;
            transition: transform 0.1s;
        `;
        document.body.appendChild(newCursor);
    }
    
    const cursorElement = document.querySelector('.cursor');
    if (cursorElement) {
        cursorElement.style.left = e.clientX - 10 + 'px';
        cursorElement.style.top = e.clientY - 10 + 'px';
    }
});


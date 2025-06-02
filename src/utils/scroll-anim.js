const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('show');
        } else {
            entry.target.classList.remove('show');
        }
    });
}, {
    rootMargin: '-20% 0px',
});

const hiddenElements = document.querySelectorAll('.hidden, .hidden-alt');
hiddenElements.forEach(el => observer.observe(el));
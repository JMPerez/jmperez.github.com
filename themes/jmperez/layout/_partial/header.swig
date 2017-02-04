<header>
    <nav id="menu">
        <a href="/"{% if is_current('index.html') %} aria-current{% endif %}>JMPerez Blog</a>
        <a href="/projects/"{% if is_current('projects/') %} aria-current{% endif %}>Projects</a>
        <a href="/about-me/"{% if is_current('about-me/') %} aria-current{% endif %}>About</a>
    </nav>
</header>

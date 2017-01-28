<header>
    <nav id="menu">
        <a href="/"{% if is_current('index.html') %} aria-current="page"{% endif %}>JMPerez Blog</a>
        <a href="/projects/"{% if is_current('projects/') %} aria-current="page"{% endif %}>Projects</a>
        <a href="/about-me/"{% if is_current('about-me/') %} aria-current="page"{% endif %}>About</a>
    </nav>
</header>

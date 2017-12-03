<header class="main-header">
    <nav id="menu">
        <a href="/"{% if is_current('index.html') %} aria-current{% endif %}>Blog</a>
        <a href="/projects/"{% if is_current('projects/') %} aria-current{% endif %}>Projects</a>
        <a href="/talks/"{% if is_current('talks/') %} aria-current{% endif %}>Speaking</a>
        <a href="/about-me/"{% if is_current('about-me/') %} aria-current{% endif %}>About</a>
    </nav>
</header>

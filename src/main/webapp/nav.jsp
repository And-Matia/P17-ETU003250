<%-- navbar.jsp --%>
<nav class="navbar">
    <div class="nav-container">
        <a href="list" class="nav-logo">Credit Manager</a>
        <ul class="nav-menu">
            <li class="nav-item"><a href="list" class="nav-link">Dashboard</a></li>
            <li class="nav-item"><a href="credit.jsp" class="nav-link">Add Credit</a></li>
            <li class="nav-item"><a href="depense" class="nav-link">Add Expense</a></li>
        </ul>
    </div>
</nav>

<style>
    .navbar {
        background-color: #2c3e50;
        padding: 1rem;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .nav-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .nav-logo {
        color: white;
        font-weight: bold;
        font-size: 1.5rem;
        text-decoration: none;
    }

    .nav-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .nav-item {
        margin-left: 1.5rem;
    }

    .nav-link {
        color: #ecf0f1;
        text-decoration: none;
        font-size: 1rem;
        transition: color 0.3s;
    }

    .nav-link:hover {
        color: #3498db;
    }

    @media (max-width: 768px) {
        .nav-container {
            flex-direction: column;
        }

        .nav-menu {
            margin-top: 1rem;
        }

        .nav-item {
            margin: 0 0.75rem;
        }
    }
</style>
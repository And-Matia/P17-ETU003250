<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Crédits</title>
    <link rel="stylesheet" href="assets/css/credit-styles.css">
</head>
<body>
    <%@ include file="nav.jsp" %>
    <div class="container">
        <header>
            <h1>Gestion des Crédits</h1>
            <p>Ajoutez un nouveau crédit</p>
        </header>
        
        <main>
            <section class="form-section">
                <form action="addCredit" method="post" id="creditForm">
                    <div class="form-group">
                        <label for="name">Nom du crédit</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="montant">Montant</label>
                        <input type="number" id="montant" name="montant" step="0.01" min="0" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="date">Date</label>
                        <input type="date" id="date" name="date" required>
                    </div>

                    
                    <div class="form-actions">
                        <button type="submit" class="btn primary">Ajouter le crédit</button>
                        <button type="reset" class="btn secondary">Réinitialiser</button>
                    </div>
                </form>
            </section>
        </main>
        
        <footer>
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> Gestion des Crédits</p>
        </footer>
    </div>
</body>
</html>

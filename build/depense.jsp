<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Models.Depense" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Models.Credit" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Dépenses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        form {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        input[type=text], input[type=number], input[type=date] {
            padding: 8px;
            margin: 5px;
            width: 200px;
        }
        input[type=submit] {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .actions {
            display: flex;
            gap: 5px;
        }
        .actions a {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            border-radius: 3px;
        }
        .edit {
            background-color: #2196F3;
        }
        .delete {
            background-color: #f44336;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
    <h1>Gestion des Dépenses</h1>
    
    <% 
        // Message de confirmation si disponible
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) {
    %>
        <div style="color: green; margin: 10px 0;">
            <%= message %>
        </div>
    <% } %>
    

    <form action="addDepense" method="post">
        <h2>Ajouter une dépense</h2>
        <div>
            <label for="credit">Crédit:</label>
            <select id="credit" name="credit" required>
                <%
                    List<Credit> listCredits = (List<Credit>) request.getAttribute("listCredits");
                    if (listCredits != null && !listCredits.isEmpty()) {
                        for (Credit credit : listCredits) {
                %>
                <option value="<%= credit.id %>"><%= credit.name %></option>
                <%
                    }
                } else {
                %>
                <option value="">Aucun crédit disponible</option>
                <%
                    }
                %>
            </select>
        </div>
        <div>
            <label for="montant">Montant:</label>
            <input id="montant" type="number" step="0.01" name="montant" required>
        </div>
        <div>
            <label for="date">Date:</label>
            <input id="date" type="date" name="date" required>
        </div>
        <input type="hidden" name="action" value="add">
        <input type="submit" value="Ajouter">
    </form>
    

</body>
</html>

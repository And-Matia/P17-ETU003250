<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Models.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Credit Expenses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .credit-section {
            margin-bottom: 30px;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
        }
        .credit-header {
            background-color: #f5f5f5;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 3px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .empty-message {
            font-style: italic;
            color: #777;
        }
        .filter-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f8f8;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            gap: 15px;
            align-items: center;
        }
        .filter-section input, .filter-section button {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .filter-section button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .filter-section button:hover {
            background-color: #45a049;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <%@ include file="nav.jsp" %>
    <h1>Dashboard - Credit Expenses History</h1>
    
    <div class="filter-section">
        <label for="startDate">From:</label>
        <input type="date" id="startDate">
        <label for="endDate">To:</label>
        <input type="date" id="endDate">
        <button onclick="filterByDate()">Filter</button>
        <button onclick="resetFilter()">Reset</button>
    </div>
    
    <%
        HashMap<Credit, List<Depense>> results = (HashMap<Credit, List<Depense>>) request.getAttribute("results");
        if (results != null && !results.isEmpty()) {
            for (Map.Entry<Credit, List<Depense>> entry : results.entrySet()) {
                Credit credit = entry.getKey();
                List<Depense> depenses = entry.getValue();
    %>
                <div class="credit-section" data-date="<%= credit.date %>">
                    <div class="credit-header">
                        <h2><%= credit.name %></h2>
                        <p>Reste: <%= credit.montant %></p>
                        <p>Date: <%= credit.date %></p>
                    </div>
                    
                    <h3>Expenses:</h3>
                    <% if (depenses != null && !depenses.isEmpty()) { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Amount</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Depense depense : depenses) { %>
                                    <tr class="expense-row" data-date="<%= depense.date %>">
                                        <td><%= depense.id %></td>
                                        <td><%= depense.montant %></td>
                                        <td><%= depense.date %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p class="empty-message">No expenses recorded for this credit.</p>
                    <% } %>
                </div>
    <%
            }
        } else {
    %>
            <p class="empty-message">No credits found.</p>
    <% } %>

    <script>
        function formatDateString(dateString) {
            // Convert various date formats to YYYY-MM-DD for comparison
            let date = new Date(dateString);
            return date.toISOString().split('T')[0];
        }
        
        function filterByDate() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            if (!startDate && !endDate) {
                alert("Please select at least one date for filtering.");
                return;
            }
            
            const startTimestamp = startDate ? new Date(startDate).getTime() : 0;
            const endTimestamp = endDate ? new Date(endDate).getTime() : Infinity;
            
            // Filter credit sections
            const creditSections = document.querySelectorAll('.credit-section');
            creditSections.forEach(section => {
                const creditDateStr = section.getAttribute('data-date');
                const creditDate = new Date(formatDateString(creditDateStr)).getTime();
                
                if (creditDate >= startTimestamp && creditDate <= endTimestamp) {
                    section.classList.remove('hidden');
                } else {
                    section.classList.add('hidden');
                }
            });
            
            // Filter expense rows within visible credit sections
            const expenseRows = document.querySelectorAll('.expense-row');
            expenseRows.forEach(row => {
                if (row.closest('.credit-section').classList.contains('hidden')) {
                    return; // Skip rows in hidden sections
                }
                
                const expenseDateStr = row.getAttribute('data-date');
                const expenseDate = new Date(formatDateString(expenseDateStr)).getTime();
                
                if (expenseDate >= startTimestamp && expenseDate <= endTimestamp) {
                    row.classList.remove('hidden');
                } else {
                    row.classList.add('hidden');
                }
            });
        }
        
        function resetFilter() {
            document.getElementById('startDate').value = '';
            document.getElementById('endDate').value = '';
            
            // Show all credit sections and expense rows
            document.querySelectorAll('.credit-section, .expense-row').forEach(element => {
                element.classList.remove('hidden');
            });
        }
    </script>
</body>
</html>

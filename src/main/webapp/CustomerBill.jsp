<%@page import="com.jsp.shoppingcart.dto.Item"%>
<%@page import="com.jsp.shoppingcart.dto.Customer"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Bill</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 15px;
        text-align: left;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <%
    // Retrieve customer details
    Customer customer = (Customer) request.getAttribute("customerinfo");
    
    // Retrieve items and total price
    List<Item> items = (List<Item>) request.getAttribute("itemslist");
    Object totalpriceObj = request.getAttribute("totalprice");
    double totalprice = 0.0; // Default value in case the attribute is null

    if (totalpriceObj instanceof Double) {
        totalprice = (Double) totalpriceObj;
    } else if (totalpriceObj instanceof String) {
        try {
            totalprice = Double.parseDouble((String) totalpriceObj);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
    %>

    <h1>Customer Bill</h1>

    <h2>Customer Details</h2>
    <p>Name: <%= (customer != null) ? customer.getName() : "N/A" %></p>
    <p>Email: <%= (customer != null) ? customer.getEmail() : "N/A" %></p>
    <p>Address: <%= (customer != null) ? customer.getAddress() : "N/A" %></p>
    <p>Mobile Number: <%= (customer != null) ? customer.getMobilenumber() : "N/A" %></p>

    <h2>Purchased Items</h2>
    <table>
        <tr>
            <th>Brand</th>
            <th>Model</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
        </tr>
        <%
        if (items != null) {
            for (Item item : items) {
                double itemTotal = item.getPrice() * item.getQuantity();
        %>
        <tr>
            <td><%= item.getBrand() %></td> <!-- Line 50 -->
            <td><%= item.getModel() %></td>
            <td><%= item.getCategory() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= itemTotal %></td>
        </tr>
        <%
            }
        }
        %>
    </table>

    <h2>Total Price: <%= totalprice %></h2>
    <br>

    <a href="addorder">Confirm Order</a>
</body>
</html>

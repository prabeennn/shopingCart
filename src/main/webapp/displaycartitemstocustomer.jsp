<%@page import="com.jsp.shoppingcart.dto.Item"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
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

	<table cellPadding="20px" border="1">
		<th>Brand</th>
		<th>Model</th>
		<th>Category</th>
		<th>Price</th>
		<th>Quantity</th>

		<%
		for (Item i : items) {
		%>
		<tr>
			<td><%=i.getBrand()%></td>
			<td><%=i.getModel()%></td>
			<td><%=i.getCategory()%></td>
			<td><%=i.getPrice()%></td>
			<td><%=i.getQuantity()%></td>
		</tr>
		<%
		}
		%>

	</table>
	<h2>TotalPrice :<%=totalprice%> </h2>
	<br>

	<a href="addorder">Buy Now</a>
</body>
</html>
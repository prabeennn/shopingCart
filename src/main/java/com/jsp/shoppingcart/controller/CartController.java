package com.jsp.shoppingcart.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jsp.shoppingcart.dao.CartDao;
import com.jsp.shoppingcart.dao.CustomerDao;
import com.jsp.shoppingcart.dto.Cart;
import com.jsp.shoppingcart.dto.Customer;
import com.jsp.shoppingcart.dto.Item;

@Controller
public class CartController {
	@Autowired
	CartDao dao;

	@Autowired
	CustomerDao custdao;

	@RequestMapping("/fetchitemsfromcart")
	public ModelAndView fetchItemsFromCart(HttpSession session) {
		Customer c = (Customer) session.getAttribute("customerinfo");

//		Customer customer = custdao.findCustomerById(c.getId());
//		Cart cart = customer.getCart();
//		List<Item> items = cart.getItems();
		if (c == null) {
            return new ModelAndView("errorpage", "message", "Customer not found in session.");
        }

        Customer customer = custdao.findCustomerById(c.getId());
        if (customer == null) {
            return new ModelAndView("errorpage", "message", "Customer not found in database.");
        }

        Cart cart = customer.getCart();
        if (cart == null) {
            return new ModelAndView("errorpage", "message", "Cart not found for customer.");
        }

        List<Item> items = cart.getItems();
        if (items == null || items.isEmpty()) {
            return new ModelAndView("errorpage", "message", "No items found in cart.");
        }

		ModelAndView mav = new ModelAndView();
		mav.addObject("itemslist", items);
		mav.addObject("totalprice", cart.getTotalprice());
		mav.setViewName("displaycartitemstocustomer");

		return mav;

	}


}

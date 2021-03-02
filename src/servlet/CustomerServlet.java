package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.CustomerDAO;
import model.Customer;


@WebServlet("/customer/*")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CustomerDAO customerDAO;

	public CustomerServlet() {
		super();
		customerDAO = new CustomerDAO();
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String url = request.getRequestURL().toString();
		String query = request.getQueryString();
		if (url.endsWith("get")) {
			if (query.startsWith("name")) {
				getCustomerByName(request, response);
			}
		} else if (url.endsWith("insert")) {			
			insertCustomer(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void getCustomerByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String customer_name = request.getParameter("name");
		try {			
			List<Customer> listCustomer = customerDAO.getCustomerByName(customer_name);			
			String customersJson = new Gson().toJson(listCustomer);
			response.getWriter().print(customersJson);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void insertCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String cardNumber = request.getParameter("cardNumber");
		String address = request.getParameter("address");
		String dob = request.getParameter("dob");		
		Customer customer = new Customer(-1, name, email, cardNumber, address, Date.valueOf(dob), phone, false);
		System.out.println(customer);
		
		try {
			customerDAO.insert(customer);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		HttpSession session = request.getSession();
		session.setAttribute("c_added", customer);		
		response.sendRedirect(request.getContextPath() + "/admin/car_reception.jsp");
	}

}

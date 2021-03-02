package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.CarReceptionBillDAO;
import dao.CarReceptionDAO;
import model.Car;
import model.CarReception;
import model.CarReceptionBill;
import model.CarReceptionPart;
import model.CarReceptionService;
import model.Customer;
import model.Part;
import model.Service;
import model.Staff;

/**
 * Servlet implementation class CarReceptionServlet
 */
@WebServlet("/carReception/*")
public class CarReceptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CarReceptionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String url = request.getRequestURL().toString();
		String query = request.getQueryString();
		if (url.endsWith("insert")) {
			insertCarReception(request, response);
		} else if (url.endsWith("get")) {
			if (query == null || query.isEmpty()) {
				getAllCarReception(request, response);
			} else if (query.startsWith("customer_id")) {
				getCarReceptionByCustomer(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private void getCarReceptionByCustomer(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));

		// DAO
		CarReceptionDAO carReceptionDAO = new CarReceptionDAO();
		CarReceptionBillDAO billDAO = new CarReceptionBillDAO();

		// list carReception of customer
		List<CarReception> carReceptions = null;
		// represent car_reception paid or not
		boolean[] paids = null;
		try {
			// get car reception by customer id
			carReceptions = carReceptionDAO.getCarReceptionByCustomer(customer_id);
			paids = new boolean[carReceptions.size()];

			for (int i = 0; i < carReceptions.size(); ++i) {
				int car_reception_id = carReceptions.get(i).getId();
				// get car_reception_bill
				CarReceptionBill bill = billDAO.get(car_reception_id);
				// paid
				if (bill != null) {
					paids[i] = true;
				} else {
					paids[i] = false;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		HttpSession session = request.getSession();
		session.setAttribute("crs", carReceptions);
		session.setAttribute("paids", paids);

		String output = new Gson().toJson(Arrays.asList(carReceptions, paids));
		// send result back
		response.getWriter().println(output);
	}

	private void getAllCarReception(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

	}

	private void insertCarReception(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		
		// get parameter
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		//int sale_staff_id = (Staff) session.getAttribute("user"); // hard code :v session.getAttribute("user_id");
		int technical_staff_id = Integer.parseInt(request.getParameter("technical_staff_id"));
		String[] sps = request.getParameterValues("sp");
		String[] quantitysps = request.getParameterValues("sp_quantity");
		String[] types = request.getParameterValues("sp_type");
		String infoCar = request.getParameter("infoCar");
		String statusCar = request.getParameter("statusCar");

		// init DAO
		CarReceptionDAO carReceptionDAO = new CarReceptionDAO();

		// init customer
		Customer customer = new Customer();
		customer.setId(customer_id);

		// initialize car
		Car car = new Car(-1, customer, infoCar, statusCar);
		// init Staff(sale staff, technical staff)
		Staff saleStaff = (Staff) session.getAttribute("user");		
		Staff technicalStaff = new Staff();
		technicalStaff.setId(technical_staff_id);

		// init CarReception
		CarReception carReception = new CarReception(-1, customer, car, new Date(System.currentTimeMillis()),
				new Date(System.currentTimeMillis()), saleStaff, technicalStaff, null, null);

		// init CarReceptionService
		List<CarReceptionService> carReceptionServices = new ArrayList<>();
		for (int i = 0; i < sps.length; ++i) {
			// service
			if (types[i].equals("service")) {
				int service_id = Integer.parseInt(sps[i]);
				// init service
				Service service = new Service();
				service.setId(service_id);
				int quantity = Integer.parseInt(quantitysps[i]);
				carReceptionServices.add(new CarReceptionService(carReception, service, quantity));
			}
		}
		// init CarReceptionPart
		List<CarReceptionPart> carReceptionParts = new ArrayList<>();
		for (int i = 0; i < sps.length; ++i) {
			// service
			if (types[i].equals("part")) {
				int part_id = Integer.parseInt(sps[i]);
				// init part
				Part part = new Part();
				part.setId(part_id);
				int quantity = Integer.parseInt(quantitysps[i]);
				carReceptionParts.add(new CarReceptionPart(carReception, part, quantity));
			}
		}

		// set parts, services
		carReception.setParts(carReceptionParts);
		carReception.setServices(carReceptionServices);

		// insert CarReception
		boolean result = carReceptionDAO.insert(carReception);

		
		if (result == true)
			session.setAttribute("msg", "Nhận xe thành công");
		else
			session.setAttribute("msg", "Có lỗi xảy ra, Vui lòng thử lại");
		
		response.sendRedirect(request.getContextPath() + "/admin/car_reception.jsp");
	}

}

package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CarReceptionBillDAO;
import model.CarReception;
import model.CarReceptionBill;
import model.CarReceptionPart;
import model.CarReceptionService;
import model.Part;
import model.Service;
import model.Staff;

/**
 * Servlet implementation class CarReceptionBillServlet
 */
@WebServlet("/CarReceptionBill/*")
public class CarReceptionBillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CarReceptionBillDAO billDAO;
	
	public CarReceptionBillServlet() {
		super();
		billDAO = new CarReceptionBillDAO();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String url = request.getRequestURL().toString();
		String query = request.getQueryString();
		if (url.endsWith("insert")) {
			insertCarReceptionBill(request, response);
		} else if (url.endsWith("get")) {
			if (query == null || query.isEmpty()) {
//				getAllCarReception(request, response);
			} else if (query.startsWith("customer_id")) {
//				getCarReceptionByCustomer(request, response);
			}
		} else if (url.endsWith("update")) {
//			updateCarReception(request, response);
		}
	}

	private void insertCarReceptionBill(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		int car_reception_id = Integer.parseInt(request.getParameter("car_reception_id"));
		String changed = request.getParameter("changed");
		
//		// get id staff
//		int payment_staff_id = 38; // hard code -> session.get
		// init payment staff
		Staff paymentStaff = (Staff) session.getAttribute("user");
		
		// init car reception bill (created_date, payment_staff)
		CarReceptionBill crBill = new CarReceptionBill();
		crBill.setId(car_reception_id);
		crBill.setCreatedDateBill(new Date(System.currentTimeMillis()));
		crBill.setPaymentStaff(paymentStaff);
		
		boolean ok = true;
		if (changed.equals("true")) {
			System.out.println("chinh sua");
			String[] sps = request.getParameterValues("sp");
			String[] quantitysps = request.getParameterValues("sp_quantity");
			String[] types = request.getParameterValues("sp_type");

			// init Car Reception
			CarReception cr = new CarReception();
			cr.setId(car_reception_id);

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
					carReceptionServices.add(new CarReceptionService(cr, service, quantity));
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
					carReceptionParts.add(new CarReceptionPart(cr, part, quantity));
				}
			}						
			crBill.setUpdatedDate(new Date(System.currentTimeMillis()));
			crBill.setServices(carReceptionServices);
			crBill.setParts(carReceptionParts);
			// add bill, car reception changed
			try {
				billDAO.insert(crBill, true);				
			} catch (Exception e) {
				e.printStackTrace();
				ok = false;				
			}
		} else { // no change car reception , add bill
			// init car reception bill
			try {
				billDAO.insert(crBill, false);				
			} catch (Exception e) {				
				e.printStackTrace();
				ok = false;
			}
		}		
		String msg = (ok == true) ? "Xác nhận hóa đơn thành công" : "Có lỗi xác nhận hóa đơn";
		
		session.setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath()+"/admin/payment_bill.jsp?id="+car_reception_id);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

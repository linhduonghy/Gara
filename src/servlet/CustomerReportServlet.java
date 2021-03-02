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

import dao.CustomerReportDAO;
import model.CustomerReport;

/**
 * Servlet implementation class CustomerReportServlet
 */
@WebServlet("/customer_report/get")
public class CustomerReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		
		String report_type = request.getParameter("report_type");

		// other report, not customer_report
		if (!report_type.trim().endsWith("khách hàng")) {
			session.removeAttribute("customerReports");
			session.removeAttribute("total");
			response.sendRedirect(request.getContextPath() + "/admin/report.jsp");
		} else {
			Date startDate = Date.valueOf(request.getParameter("startDate"));
			Date endDate = Date.valueOf(request.getParameter("endDate"));
			System.out.println(startDate + " " + endDate);
			CustomerReportDAO reportDAO = new CustomerReportDAO();
			List<CustomerReport> customerReports = null;
			try {
				customerReports = reportDAO.getCustomerReports(startDate, endDate);
				System.out.println(customerReports);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
			if (customerReports == null) {
				response.sendRedirect(request.getContextPath() + "/admin/report.jsp");
				return;
			}
			float sum = customerReports.stream().map(c -> c.getRevenue()).reduce((float) 0, (a, b) -> a + b);
			
			session.setAttribute("customerReports", customerReports);
			session.setAttribute("total", sum);
			response.sendRedirect(request.getContextPath() + "/admin/report.jsp");
		}
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

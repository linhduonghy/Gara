package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Customer;
import model.CustomerReport;

public class CustomerReportDAO extends DAO{
	public CustomerReportDAO() {
		super();
	}
	public List<CustomerReport> getCustomerReports(Date startDate, Date endDate) 
			throws SQLException {
		List<CustomerReport> customerReports = new ArrayList<CustomerReport>();		
		// store list pair<customer_id,revenue>
		Map<Integer, Float> list = new HashMap<Integer, Float>();				
		// get service revenue of customer
		String sql1 = "select c.id customer_id,sum(crs.quantity*service.price) total "+ 
				"from customer c inner join car_reception cr on c.id=cr.customer_id "+ 
				"inner join car_reception_bill crb on crb.id = cr.id "+ 
				"inner join car_reception_service crs on crs.car_reception_id=cr.id "+ 
				"inner join service on service.id = crs.service_id "+ 
				"where crb.created_date between ? and ? group by c.id";
		PreparedStatement pstm = conn.prepareStatement(sql1);
		pstm.setDate(1, startDate); pstm.setDate(2, endDate);
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {	
			// put customer_id,total to list 
			list.put(rs.getInt("customer_id"), rs.getFloat("total"));			
		}
		// get part revenue of customer
		String sql2 = "select c.id customer_id,sum(crp.quantity*part.price) as total "+ 
				"from customer c inner join car_reception cr on c.id=cr.customer_id "+ 
				"inner join car_reception_bill crb on crb.id = cr.id " + 
				"inner join car_reception_part crp on crp.car_reception_id = cr.id " + 
				"inner join part on part.id = crp.part_id " + 
				"where crb.created_date between ? and ? group by c.id";
		pstm = conn.prepareStatement(sql2);
		pstm.setDate(1, startDate); pstm.setDate(2, endDate);
		rs = pstm.executeQuery();
		while (rs.next()) {		
			int customer_id = rs.getInt("customer_id");
			float part_revenue = rs.getFloat("total");
			Float service_revenue = list.get(customer_id);
			// service_revenue != 0 
			// -> customer used services in car receptions
			if (service_revenue != null) {
				list.put(customer_id, part_revenue + service_revenue);
			} else { // service revenue = 0 -> customer didn't use services
				list.put(customer_id, part_revenue);
			}
		}
		CustomerDAO customerDAO = new CustomerDAO();
		// list -> List<CustomerReport>
		for (Map.Entry<Integer, Float> item : list.entrySet()) {
			int customer_id = item.getKey();
			float total = item.getValue();
			Customer customer = customerDAO.get(customer_id);
			customerReports.add(new CustomerReport(customer, startDate, endDate, total));
		}
		return customerReports.size() > 0 ? customerReports : null;
	}
	
	public static void main(String[] args) throws SQLException {
		CustomerReportDAO crd = new CustomerReportDAO();
		System.out.println(crd.getCustomerReports(Date.valueOf("2020-10-10"), Date.valueOf("2020-11-11")));
	}
}

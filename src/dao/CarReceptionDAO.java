package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Car;
import model.CarReception;
import model.CarReceptionPart;
import model.CarReceptionService;
import model.Customer;
import model.Staff;

public class CarReceptionDAO extends DAO{

	private CarReceptionServiceDAO crServiceDAO;
	private CarReceptionPartDAO crPartDAO;
	private StaffDAO staffDAO;
	private CarDAO carDAO;
	private CustomerDAO customerDAO;
	
	public CarReceptionDAO() {
		super();
		crServiceDAO = new CarReceptionServiceDAO();
		crPartDAO = new CarReceptionPartDAO();
		staffDAO = new StaffDAO();
		carDAO = new CarDAO();
		customerDAO = new CustomerDAO();
	}

	public boolean insert(CarReception cr) {
		
		try {
			// set commit false to roll back if exception occur
			conn.setAutoCommit(false);
			// insert car
			carDAO.insert(cr.getCar());			
			// insert car reception
			String sql = "insert into car_reception(customer_id,car_id,created_date,updated_date,"
					+ "sale_staff_id,technical_staff_id) values(?,?,?,?,?,?)";
			PreparedStatement pstm = conn.prepareStatement(sql, 
					Statement.RETURN_GENERATED_KEYS);
			pstm.setInt(1, cr.getCustomer().getId());		
			pstm.setInt(2, cr.getCar().getId());
			pstm.setDate(3, cr.getCreatedDate());		
			pstm.setDate(4, cr.getUpdatedDate());
			pstm.setInt(5, cr.getSaleStaff().getId());
			pstm.setInt(6, cr.getTechnicalStaff().getId());
			int row = pstm.executeUpdate();
			if (row == 0) {
				throw new SQLException("failed to insert car reception");
			}
			
			// set car_reception_id
			ResultSet rs = pstm.getGeneratedKeys();
			if (rs.next()) {
				int id = rs.getInt(1);
				cr.setId(id);
			}
			
			// insert car_reception_part
			for (CarReceptionPart crp : cr.getParts()) {
				crPartDAO.insert(crp);
			}
			// insert car_reception_service
			for (CarReceptionService crs : cr.getServices()) {
				crServiceDAO.insert(crs);
			}
			conn.commit();
			System.out.println(">> insert car_reception");
			return true;
		} catch (Exception e) {
			try {
				// roll back
				conn.rollback();
				return false;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {			
				e.printStackTrace();
			}
		}
		return false;
	}

	public List<CarReception> getCarReceptionByCustomer(int customer_id) 
			throws SQLException {
		// result
		List<CarReception> result = new ArrayList<CarReception>();
		// 
		String sql = "select id,customer_id,car_id,created_date,updated_date,sale_staff_id,technical_staff_id"
				+ " from car_reception where customer_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, customer_id);
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			result.add(mapRowToCarReception(rs));
		}
		return result;
	}
	
	
	public CarReception getCarReception(int id) throws SQLException {		
		String sql = "select id,customer_id,car_id,created_date,updated_date,sale_staff_id,"
				+ "technical_staff_id from car_reception where id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if (rs.next()) {			
			return mapRowToCarReception(rs);
		}
		return null;
	}
	private CarReception mapRowToCarReception(ResultSet rs) throws SQLException{
		int car_reception_id = rs.getInt("id");
		Date createdDate = rs.getDate("created_date");
		Date updatedDate = rs.getDate("updated_date");
		Car car = carDAO.get(rs.getInt("car_id"));
		Customer customer = customerDAO.get(rs.getInt("customer_id"));
		Staff saleStaff = staffDAO.get(rs.getInt("sale_staff_id"));
		Staff technicalStaff = staffDAO.get(rs.getInt("technical_staff_id"));
		List<CarReceptionService> services = crServiceDAO.getByCarReceptionId(
				car_reception_id);
		List<CarReceptionPart> parts = crPartDAO.getByCarReceptionId(
				car_reception_id);	
		CarReception carReception = new CarReception(car_reception_id, customer, 
				car, createdDate, updatedDate, saleStaff, technicalStaff, parts, services);
		return carReception;
	}
	
	public void update(CarReception cr) throws SQLException {		
		String sqlUpdateCR = "update car_reception set updated_date = ? "
				+ "where id = ?";
		PreparedStatement pstm = conn.prepareStatement(sqlUpdateCR);
		pstm.setDate(1, cr.getUpdatedDate());
		pstm.setInt(2, cr.getId());
		pstm.executeUpdate();
		System.out.println(">> update car_reception");
	}
}

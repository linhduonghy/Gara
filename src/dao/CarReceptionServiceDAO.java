package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CarReception;
import model.CarReceptionService;
import model.Service;

public class CarReceptionServiceDAO extends DAO {

	ServiceDAO serviceDAO;
	public CarReceptionServiceDAO() {
		super();
		serviceDAO = new ServiceDAO();
	}
	public void insert(CarReceptionService t) throws SQLException {
		String sqlInsertCrs = "insert into car_reception_service(car_reception_id,"
				+ "service_id,quantity) values(?,?,?)";
		// insert car_reception_service
		PreparedStatement pstmCRP = conn.prepareStatement(sqlInsertCrs);
		pstmCRP.setInt(1, t.getCarReception().getId());
		pstmCRP.setInt(2, t.getService().getId());
		pstmCRP.setInt(3, t.getQuantity());
		pstmCRP.executeUpdate();
		System.out.println(">> insert car reception service");

	}

	public List<CarReceptionService> getAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public CarReceptionService get(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public void update(CarReceptionService t) throws SQLException {
		

	}

	public void deleteByCarReception(int car_reception_id) throws SQLException {
		
		String sqlDel = "delete from car_reception_service where car_reception_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sqlDel);
		pstm.setInt(1, car_reception_id);
		pstm.executeUpdate();
		
		System.out.println(">> delete car_reception_service by car_reception");
	}

	public List<CarReceptionService> getByCarReceptionId(int car_reception_id) throws SQLException {
		String sql = "select service_id,quantity from car_reception_service "
				+ "where car_reception_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, car_reception_id);
		ResultSet rs = pstm.executeQuery();
		List<CarReceptionService> result = new ArrayList<CarReceptionService>();

		while (rs.next()) {
			CarReception carReception = new CarReception();
			carReception.setId(car_reception_id);
			Service service = serviceDAO.get(rs.getInt("service_id"));
			result.add(new CarReceptionService(carReception, service, rs.getInt("quantity")));
		}
		return result.size() == 0 ? null : result;
	}

	
}

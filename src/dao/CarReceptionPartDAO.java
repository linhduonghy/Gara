package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CarReception;
import model.CarReceptionPart;
import model.Part;

public class CarReceptionPartDAO extends DAO {

	private PartDAO partDAO;

	public CarReceptionPartDAO() {
		super();
		partDAO = new PartDAO();
	}

	public void insert(CarReceptionPart t) throws SQLException {
		Part part = partDAO.get(t.getPart().getId());
		String sqlInsertCrp = "insert into car_reception_part(car_reception_id," + "part_id,quantity) values(?,?,?)";
		String sqlUpdatePart = "update part set quantity_in_stock = ? where id=?";

		// insert car_reception_part
		PreparedStatement pstmCRP = conn.prepareStatement(sqlInsertCrp);
		pstmCRP.setInt(1, t.getCarReception().getId());
		pstmCRP.setInt(2, t.getPart().getId());
		pstmCRP.setInt(3, t.getQuantity());
		pstmCRP.executeUpdate();
		// update part(quantity_in_stock) -= t.quantity
		PreparedStatement pstmPart = conn.prepareStatement(sqlUpdatePart);
		pstmPart.setInt(1, part.getQuantityInStock() - t.getQuantity());
		pstmPart.setInt(2, part.getId());
		pstmPart.executeUpdate();

		System.out.println(">> insert car reception part");
	}

	public List<CarReceptionPart> getAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public CarReceptionPart get(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(CarReceptionPart crp) throws SQLException {

		String sqlDel = "delete from car_reception_part where car_reception_id = ? and part_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sqlDel);
		pstm.setInt(1, crp.getCarReception().getId());
		pstm.setInt(2, crp.getPart().getId());
		pstm.executeUpdate();

		Part part = partDAO.get(crp.getPart().getId());		
		String sqlUpdatePart = "update part set quantity_in_stock = ? where id=?";
		// update part(quantity_in_stock) += crp.quantity
		PreparedStatement pstmPart = conn.prepareStatement(sqlUpdatePart);
		pstmPart.setInt(1, part.getQuantityInStock() + crp.getQuantity());
		pstmPart.setInt(2, part.getId());
		pstmPart.executeUpdate();
		
		System.out.println(">> delete car_reception_part by car_reception and part");
	}


	public List<CarReceptionPart> getByCarReceptionId(int car_reception_id) throws SQLException {

		String sql = "select part_id,quantity from car_reception_part " + "where car_reception_id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, car_reception_id);
		ResultSet rs = pstm.executeQuery();
		List<CarReceptionPart> result = new ArrayList<CarReceptionPart>();

		while (rs.next()) {
			CarReception carReception = new CarReception();
			carReception.setId(car_reception_id);
			Part part = partDAO.get(rs.getInt("part_id"));
			result.add(new CarReceptionPart(carReception, part, rs.getInt("quantity")));
		}
		return result.size() == 0 ? null : result;
	}

}

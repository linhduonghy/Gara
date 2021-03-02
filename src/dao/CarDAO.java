package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import model.Car;

public class CarDAO extends DAO{

	public CarDAO() {
		super();
	}
	public List<Car> getAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	public Car get(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	public void insert(Car t) throws SQLException {
		String sql = "insert into car(info,status,customer_id) values(?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstm.setString(1, t.getInfomation());
		pstm.setString(2, t.getStatus());
		pstm.setInt(3, t.getCustomer().getId());
		
		pstm.executeUpdate();
		
		ResultSet rs = pstm.getGeneratedKeys();
		if (rs.next()) {
			int id = rs.getInt(1);
			t.setId(id);
		}
		System.out.println("insert car");
	}
	public void update(Car t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	public void delete(Car t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}

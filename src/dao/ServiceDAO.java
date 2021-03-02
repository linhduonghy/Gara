package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Service;

public class ServiceDAO extends DAO {
	public ServiceDAO() {
		super();
	}
	public List<Service> getServiceByName(String name) throws SQLException {
		String sql = "select id,name,description,years_warranty,price from service "
				+ "where upper(name) like ?";
		List<Service> result = new ArrayList<Service>();
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, "%" + name + "%");
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			result.add(mapRowToService(rs));
		}
		return result;
	}
	public List<Service> getAll() throws SQLException {
		List<Service> result = new ArrayList<Service>();
		String sql = "select id,name,description,years_warranty,price "
				+ "from service";
		PreparedStatement pstm = conn.prepareStatement(sql);
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			result.add(mapRowToService(rs));
		}
		return result;
	}

	public Service get(int id) throws SQLException {		
		String sql = "select id,name,description,years_warranty,price "
				+ "from service where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if (rs.next()) {
			return mapRowToService(rs);
		}
		return null;
	}

	

	public void insert(Service t) throws SQLException {
		String sql = "insert into service(name,description,years_warranty,price) " + "values(?,?,?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, t.getName());
		pstm.setString(2, t.getDescription());
		pstm.setInt(3, t.getYearWarranty());
		pstm.setFloat(4, t.getPrice());

		int row = pstm.executeUpdate();
		if (row == 0) {
			throw new SQLException("failed to insert service");
		}
		System.out.println("insert service");
	}

	public void update(Service t) throws SQLException {
		// TODO Auto-generated method stub

	}

	public void delete(Service t) throws SQLException {
		// TODO Auto-generated method stub

	}

	private Service mapRowToService(ResultSet rs) throws SQLException {
		return new Service(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
				rs.getInt("years_warranty"), rs.getFloat("price"));
	}

	public static void main(String[] args) throws SQLException {
		ServiceDAO sd = new ServiceDAO();
		System.out.println(sd.getServiceByName("a"));
	}
}

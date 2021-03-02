package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Provider;

public class ProviderDAO extends DAO{

	public ProviderDAO() {
		super();
	}
	
	public List<Provider> getAll() throws SQLException {
		String sql = "select id,name,address,description from provider";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Provider> result = new ArrayList<Provider>();
		while (rs.next()) {
			result.add(mapRowToProvider(rs));
		}
		return result;
	}

	
	public Provider get(int id) throws SQLException {
		String sql = "select id,name,address,description from provider "
				+ "where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if(rs.next()) 
			return mapRowToProvider(rs);
		return null;
	}

	public void insert(Provider t) throws SQLException {
		
		String sql = "insert into provider(name,address,description) "
				+ "values(?,?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, t.getName());
		pstm.setString(2, t.getAddress());
		pstm.setString(3, t.getDescription());
		
		int row = pstm.executeUpdate();
		if (row == 0) {
			throw new SQLException("failed to insert provider");
		}
		System.out.println("insert provider");
	}

	public void update(Provider t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	public void delete(Provider t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	private Provider mapRowToProvider(ResultSet rs) throws SQLException {
		return new Provider(rs.getInt("id"), rs.getString("name"), rs.getString("address"), 
				rs.getString("description"));
	}
	
	public static void main(String[] args) throws SQLException {
		
//		Provider p = new Provider(-1, "ABC", "Hà Đông-Hà Nội", "cung cấp phụ tùng xe");
		
		ProviderDAO pd = new ProviderDAO();
//		pd.insert(p);
		
		System.out.println(pd.get(1));
		
	}
}

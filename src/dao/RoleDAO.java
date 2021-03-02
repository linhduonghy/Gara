package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Role;

public class RoleDAO extends DAO{

	public RoleDAO() {
		super();
	}

	public List<Role> getAll() throws SQLException {
		String sql = "select id,title,description from role";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Role> result = new ArrayList<Role>();
		while (rs.next()) {
			result.add(mapRowToRole(rs));
		}
		return result;
	}

	public Role get(int id) throws SQLException {
		String sql = "select id,title,description from role "
				+ "where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		
		if (rs.next()) 
			return mapRowToRole(rs);
		return null;
	}

	public void insert(Role t) throws SQLException {
		
		String sql = "insert into role(title,description) values(?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, t.getTitle());
		pstm.setString(2, t.getDescription());
		int rows = pstm.executeUpdate();
		if (rows == 0) {
			throw new SQLException("failed to insert role");
		}
		System.out.println("insert role");
		
	}

	public void update(Role t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	public void delete(Role t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	private Role mapRowToRole(ResultSet rs) throws SQLException {
		return new Role(rs.getInt("id"), rs.getString("title"), 
				rs.getString("description"));
	}
	
	public static void main(String[] args) throws SQLException {
		RoleDAO rd = new RoleDAO();
		
//		rd.insert(new Role(-1, "Nhân viên quản lý","Quản lý thông tin dịch vụ, phụ tùng, quản lý "
//				+ "thống kê"));
//		rd.insert(new Role(-1, "Nhân viên bán hàng", "nhân viên nhận khách hàng, nhận yêu cầu dịch vụ, "
//				+ "phụ tùng từ khách hàng, nhận thanh toán từ khách hàng"));
//		rd.insert(new Role(-1,"Nhân viên kho","Nhân viên nhập phụ tùng từ nhà cung cấp, quản lý "
//				+ "thông tin nhà cung cấp"));
		System.out.println(rd.get(1));
	}
}

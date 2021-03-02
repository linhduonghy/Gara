package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Member;
import model.Staff;
import util.Encryption;

public class StaffDAO extends DAO {

	MemberDAO memberDAO;
	RoleDAO roleDAO;

	public StaffDAO() {
		super();
		memberDAO = new MemberDAO();
		roleDAO = new RoleDAO();
	}

	public List<Staff> getAllTechnicalStaff() throws SQLException {
		List<Staff> result = new ArrayList<Staff>();
		String sql = "select staff.id,username,password,role_id,level " + "from staff "
				+ "inner join role on role.id = staff.role_id " + "where role.title = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, "Nhân viên kỹ thuật");
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			result.add(mapRowToStaff(rs));
		}
		return result;
	}

	public List<Staff> getAll() throws SQLException {
		String sql = "select id, username,password,role_id,level from staff";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Staff> result = new ArrayList<>();
		while (rs.next()) {
			result.add(mapRowToStaff(rs));
		}
		return result;
	}

	public Staff get(int id) throws SQLException {
		String sql = "select id, username,password,role_id,level from staff where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if (rs.next())
			return mapRowToStaff(rs);
		return null;
	}

	public void insert(Staff staff) throws SQLException {

		// add staff to table member
		memberDAO.insert(staff);

		// add to table staff
		String sql = "insert into staff(id,username,password,role_id,level) " + "values(?,?,?,?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, staff.getId());
		pstm.setString(2, staff.getUsername());
		pstm.setString(3, Encryption.encryptMD5(staff.getPassword()));
		pstm.setInt(4, staff.getRole().getId());
		pstm.setString(5, staff.getLevel());

		int row = pstm.executeUpdate();
		if (row == 0) {
			throw new SQLException("no row affected");
		}
		System.out.println("insert staff");
	}

	public Staff login(String username, String password) throws SQLException {

		// encrypt password
		password = Encryption.encryptMD5(password);
		
		String sql = "select id, username,password,role_id,level from staff where username=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, username);
		ResultSet rs = pstm.executeQuery();
		Staff staff = null;
		if (rs.next()) { //  valid user name 
			staff = mapRowToStaff(rs);
			if (staff.getPassword().equals(password)) { // correct password
				return staff;
			} else { // wrong password
				return null;
			}
		}
		// invalid user name
		return null;
	}

	private Staff mapRowToStaff(ResultSet rs) throws SQLException {
		int id = rs.getInt("id");
		Staff staff = new Staff();
		staff.setUsername(rs.getString("username"));
		staff.setPassword(rs.getString("password"));
		staff.setRole(roleDAO.get(rs.getInt("role_id")));
		staff.setLevel(rs.getString("level"));
		Member member = memberDAO.get(id);
		staff.setMember(member);
		return staff;
	}

	public static void main(String[] args) throws SQLException {
		StaffDAO sd = new StaffDAO();
//		sd.insert(s);
//		sd.insert(s1);
//		sd.insert(s2);
		System.out.println(sd.login("tu", "123"));
		
	}
}

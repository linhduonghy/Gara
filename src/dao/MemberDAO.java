package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Member;

public class MemberDAO extends DAO {

	public MemberDAO() {
		super();
	}

	public void insert(Member t) throws SQLException {
		// add table member
		String sql = "insert into member(name,email,address,phone,dob,card_number) "
				+ "values(?,?,?,?,?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql, 
				Statement.RETURN_GENERATED_KEYS);
		pstm.setString(1, t.getName());
		pstm.setString(2, t.getEmail());
		pstm.setString(3, t.getAddress());
		pstm.setString(4, t.getPhone());
		pstm.setDate(5, t.getDob());
		pstm.setString(6, t.getCardNumber());
		int affectedRows = pstm.executeUpdate();
		if (affectedRows == 0) {
			throw new SQLException("Creating customer failed, no rows affected.");
		}
		System.out.println("insert table member");
		// set member id
		ResultSet rs = pstm.getGeneratedKeys();
		if (rs.next()) {
			t.setId(rs.getInt(1));
		}
		
	}
	public List<Member> getMemberLikeName(String name) throws SQLException {
		String sql = "select id,name,email,address,dob,card_number,phone from member"
				+ " where UPPER(name) LIKE ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, "%" + name.toUpperCase() + "%");
		ResultSet rs = pstm.executeQuery();
		List <Member> result = new ArrayList<>();
		while (rs.next()) {
			result.add(mapRowToMember(rs));
		}
		return result;
	}
	
	public List<Member> getAll() throws SQLException {
		
		String sql = "select id,name,email,phone,address,dob,card_number from member";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List <Member> result = new ArrayList<>();
		while (rs.next()) {
			result.add(mapRowToMember(rs));
		}
		return result;
	}

	
	public Member get(int id) throws SQLException {
		String sql = "select id,name,email,address,dob,card_number,phone from member"
				+ " where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if (rs.next())
			return mapRowToMember(rs);
		return null;
	}
	


	public void update(Member t) throws SQLException {
		// TODO Auto-generated method stub

	}


	public void delete(Member t) throws SQLException {
		// TODO Auto-generated method stub

	}
	
	private Member mapRowToMember(ResultSet rs) throws SQLException {
		Member member = new Member(rs.getInt("id"), rs.getString("name"), rs.getString("email"), 
				rs.getString("card_number"), rs.getString("address"), rs.getDate("dob"), rs.getString("phone"));;
		return member;
	}
	public static void main(String[] args) throws SQLException {
		MemberDAO md = new MemberDAO();
		System.out.println(md.getMemberLikeName("Linh"));
	}
}

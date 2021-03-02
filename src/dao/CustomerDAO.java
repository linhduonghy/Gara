package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

public class CustomerDAO extends DAO {

	MemberDAO memberDAO;

	public CustomerDAO() {
		super();
		memberDAO = new MemberDAO();
	}
	public List<Customer> getCustomerByName(String customer_name) 
			throws SQLException {
		String sql = "select member.id id,name,email,address,phone,dob,card_number,vip "
				+ "from customer inner join member" + 
				" on member.id = customer.id" + 
				" where upper(name) like ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, "%" + customer_name + "%");
		ResultSet rs = pstm.executeQuery();
		List<Customer> result = new ArrayList<>();
		while (rs.next()) {
			Customer customer = new Customer(rs.getInt("id"), rs.getString("name"), 
					rs.getString("email"), rs.getString("card_number"), rs.getString("address"), 
					rs.getDate("dob"), rs.getString("phone"), rs.getBoolean("vip"));
			result.add(customer);
		}
		return result;
	}

	public List<Customer> getAll() throws SQLException {
		String sql = "select id, vip from customer";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Customer> result = new ArrayList<>();
		while (rs.next()) {
			result.add(mapRowToCustomer(rs));
		}
		return result;
	}

	public Customer get(int id) throws SQLException {
		String sql = "select id,vip from customer where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if (rs.next())
			return mapRowToCustomer(rs);
		return null;
	}

	public void insert(Customer t) throws SQLException {
		// add table member
		memberDAO.insert(t);
		// add table customer
		String sql = "insert into customer(id,vip) values(?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, t.getId());
		pstm.setBoolean(2, t.getVip());
		int affectedRows = pstm.executeUpdate();
		if (affectedRows == 0) {
			throw new SQLException("insert customer failed, no rows affected.");
		}
		System.out.println(">> insert customer");
	}


	public void update(Customer t) {
		// TODO Auto-generated method stub

	}


	public void delete(Customer t) {
		// TODO Auto-generated method stub

	}

	private Customer mapRowToCustomer(ResultSet rs) throws SQLException {
		int id = rs.getInt("id");
		Customer customer = new Customer(memberDAO.get(id));
		customer.setId(id);
		customer.setVip(rs.getBoolean("vip"));
		return customer;
	}

	public static void main(String[] args) throws SQLException {

		Customer c = new Customer(-1, "Hoàng Hà Linh", "linhhahoang1999", "026099001234", "Long Biên - Hà Nội",
				Date.valueOf("1999-08-22"), "0396110292", false);
		c.toString();
		CustomerDAO cd = new CustomerDAO();
//		cd.insert(c);
//		System.out.println(c);
		List<Customer> lc = cd.getCustomerByName("duong");
		System.out.println(lc);
	}

}

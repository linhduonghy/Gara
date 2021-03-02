package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Part;

public class PartDAO extends DAO{
	ProviderDAO pd;
	public PartDAO() {
		super();
		pd = new ProviderDAO();
	}	
	
	public List<Part> getPartByName(String name) throws SQLException {
		String sql = "select id,name,description,years_warranty,price,"
				+ "quantity_in_stock,provider_id "
				+ "from part "
				+ "where upper(name) like ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1,"%"+name+"%");
		ResultSet rs = pstm.executeQuery();
		List<Part> result = new ArrayList<Part>();
		while (rs.next()) {
			result.add(mapRowToPart(rs));
		}
		return result;
	}
	
	public List<Part> getAll() throws SQLException {
		String sql = "select id,name,description,years_warranty,price,quantity_in_stock,provider_id from part";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Part> result = new ArrayList<Part>();
		while (rs.next()) {
			result.add(mapRowToPart(rs));
		}
		return result;
	}

	public Part get(int id) throws SQLException {
		String sql = "select id,name,description,years_warranty,price,quantity_in_stock,provider_id from part "
				+ "where id=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, id);
		ResultSet rs = pstm.executeQuery();
		if(rs.next()) 
			return mapRowToPart(rs);
		return null;
	}

	
	public void insert(Part t) throws SQLException {
		String sql = "insert into part(name,description,years_warranty,price,quantity_in_stock,provider_id) "
				+ "values(?,?,?,?,?,?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, t.getName());
		pstm.setString(2, t.getDescription());
		pstm.setInt(3, t.getYearsWarranty());
		pstm.setFloat(4, t.getPrice());
		pstm.setInt(5, t.getQuantityInStock());
		pstm.setInt(6, t.getProvider().getId());
		
		int row = pstm.executeUpdate();
		if (row == 0) {
			throw new SQLException("failed to insert part");
		}
		System.out.println("insert part");
	}

	public void update(Part part) throws SQLException {
		
	}

	public void delete(Part t) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	private Part mapRowToPart(ResultSet rs) throws SQLException {
		Part p = new Part(rs.getInt("id"), rs.getString("name"), rs.getString("description"), 
				rs.getInt("years_warranty"), rs.getFloat("price"), rs.getInt("quantity_in_stock"),null);
		// set provider
		int provider_id = rs.getInt("provider_id");		
		p.setProvider(pd.get(provider_id));
		
		return p;
	}
	public static void main(String[] args) throws SQLException {
		
//		ProviderDAO pd = new ProviderDAO();
//		Part p = new Part(-1, "Kính xe", "", 2, 1000000, 12,pd.get(1));
		PartDAO partDAO = new PartDAO();
//		partDAO.insert(p);
		System.out.println(partDAO.getPartByName("xe"));
	}
}

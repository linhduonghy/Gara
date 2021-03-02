package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CarReception;
import model.CarReceptionBill;
import model.CarReceptionPart;
import model.CarReceptionService;

public class CarReceptionBillDAO extends DAO{
	
	private CarReceptionDAO carReceptionDAO;
	private StaffDAO staffDAO;
	public CarReceptionBillDAO() {
		super();
		carReceptionDAO = new CarReceptionDAO();
		staffDAO = new StaffDAO();
	}
	
	public void insert(CarReceptionBill crb, boolean changed) throws SQLException {
		try {
			// set commit false to roll back if exception
			conn.setAutoCommit(false);
			// paid
			if (get(crb.getId()) != null) {
				System.out.println("bill paid, so can't insert");
				return;
			}
			String sql = "insert into car_reception_bill(id,created_date,payment_staff_id) "
					+ "values(?,?,?)";		
			PreparedStatement pstm = conn.prepareStatement(sql);			
			pstm.setInt(1, crb.getId());			
			pstm.setDate(2, crb.getCreatedDateBill());		
			pstm.setInt(3, crb.getPaymentStaff().getId());
			System.out.println(crb);
			int row = pstm.executeUpdate();
			if (row == 0) {
				throw new SQLException("failed to insert bill");
			}
			
			// have change car reception
			if (changed == true) {
				// update car reception
				carReceptionDAO.update(crb);
				
				CarReceptionServiceDAO crsd = new CarReceptionServiceDAO();
				// delete car reception service by car reception
				crsd.deleteByCarReception(crb.getId());				
				for (CarReceptionService crs : crb.getServices()) {					
					// insert back car reception service
					crsd.insert(crs);
				}

				CarReceptionPartDAO crpd = new CarReceptionPartDAO();				
				for (CarReceptionPart crp : crb.getParts()) {
					// delete car reception part by car reception
					crpd.delete(crp);
					// insert back car reception service
					crpd.insert(crp);
				}
			}
			// commit insert bill
			conn.commit();
			System.out.println(">> insert bill");			
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			conn.setAutoCommit(true);
		}
		
	}
	
	public CarReceptionBill get(int bill_id) throws SQLException {
		String sql = "select created_date,payment_staff_id "
				+ "from car_reception_bill where id = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, bill_id);
		ResultSet rs = pstm.executeQuery();
		CarReceptionBill crBill = new CarReceptionBill();
		while (rs.next()) {			
			// get CarReception from bill_id
			CarReception carReception = carReceptionDAO.getCarReception(bill_id);			
			// set Bill
			crBill.setId(bill_id);
			crBill.setCreatedDateBill(rs.getDate("created_date"));
			crBill.setPaymentStaff(staffDAO.get(rs.getInt("payment_staff_id")));
			// set car_reception
			crBill.setCustomer(carReception.getCustomer());
			crBill.setCar(carReception.getCar());
			crBill.setParts(carReception.getParts());
			crBill.setSaleStaff(carReception.getSaleStaff());
			crBill.setTechnicalStaff(carReception.getTechnicalStaff());
			crBill.setServices(carReception.getServices());
			crBill.setCreatedDate(carReception.getCreatedDate());
			crBill.setUpdatedDate(carReception.getUpdatedDate());
			return crBill;
		}
		return null;
	}

	public List<CarReceptionBill> getBillByCustomerAndCreadtedDateBetween(int customer_id, 
			Date startDate, Date endDate) throws SQLException {
	
		
		String sql = "select b.id bill_id,b.created_date bill_date,payment_staff_id "
				+ "from car_reception_bill b "
				+ "inner join car_reception cr on cr.id=b.id "
				+ "where customer_id=? and (b.created_date between ? and ?)";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setInt(1, customer_id);
		pstm.setDate(2, startDate);
		pstm.setDate(3, endDate);		
		ResultSet rs = pstm.executeQuery();
		// result
		List<CarReceptionBill> bills = new ArrayList<CarReceptionBill>();
		while (rs.next()) {			
			int bill_id = rs.getInt("bill_id");
			// get car reception by bill_id
			CarReception cr = carReceptionDAO.getCarReception(bill_id);
			
			// init bill
			CarReceptionBill bill = new CarReceptionBill();
			bill.setId(bill_id);
			bill.setCreatedDateBill(rs.getDate("bill_date"));
			bill.setPaymentStaff(staffDAO.get(rs.getInt("payment_staff_id")));						
			// set bill from car reception
			bill.setCustomer(cr.getCustomer());
			bill.setCar(cr.getCar());
			bill.setParts(cr.getParts());
			bill.setSaleStaff(cr.getSaleStaff());
			bill.setTechnicalStaff(cr.getTechnicalStaff());
			bill.setServices(cr.getServices());
			bill.setCreatedDate(cr.getCreatedDate());
			bill.setUpdatedDate(cr.getUpdatedDate());
			// add bill to result
			bills.add(bill);
		}
		return bills.size() == 0 ? null : bills;
	}
	public void update(CarReceptionBill crBill) throws SQLException {
		// TODO Auto-generated method stub
		
	}
	
	
	
}

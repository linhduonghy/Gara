package model;

import java.sql.Date;
import java.util.List;

public class CarReceptionBill extends CarReception{

	private Date createdDateBill;
	private Staff paymentStaff;
	
	public CarReceptionBill() {
	}

	public CarReceptionBill(int id, Customer customer, Date createdDate, Date updatedDate,
			Staff saleStaff, Staff technicalStaff, List<CarReceptionService> services, 
			List<CarReceptionPart> parts, Car car, Date createdDateBill, Staff paymentStaff) {
		super(id, customer, car, createdDate, updatedDate, saleStaff, technicalStaff, parts, services);
		this.createdDateBill = createdDateBill;
		this.paymentStaff = paymentStaff;
	}

	
	public Date getCreatedDateBill() {
		return createdDateBill;
	}

	public void setCreatedDateBill(Date createdDateBill) {
		this.createdDateBill = createdDateBill;
	}

	public Staff getPaymentStaff() {
		return paymentStaff;
	}

	public void setPaymentStaff(Staff paymentStaff) {
		this.paymentStaff = paymentStaff;
	}

	@Override
	public String toString() {
		return "CarReceptionBill [id= " +getId()+ " createdDateBill=" + createdDateBill + ", paymentStaff=" + paymentStaff + "]";
	}
}

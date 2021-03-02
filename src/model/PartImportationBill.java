package model;

import java.util.Date;
import java.util.List;

public class PartImportationBill extends PartImportation{

	
	private Date createdDateBill;
	
	private float totalPrice;
	
	public PartImportationBill() {
		// TODO Auto-generated constructor stub
	}

	public PartImportationBill(int id, Staff warehouseStaff, Provider provider, Date createdDate,
			List<PartImportationParts> listPart, Date createdDateBill) {
		super(id, warehouseStaff, provider, createdDateBill, listPart);
		this.createdDateBill = createdDateBill;
		this.totalPrice = calTotalPrice();
	}
	
	public Date getCreatedDateBill() {
		return createdDateBill;
	}

	public void setCreatedDateBill(Date createdDateBill) {
		this.createdDateBill = createdDateBill;
	}
	
	public float getTotalPrice() {
		return totalPrice;
	}
	
	public float calTotalPrice() {
		float total = 0;
		for (PartImportationParts pip : getListPart()) {
			total += pip.getPrice();
		}
		return total;
	}

}

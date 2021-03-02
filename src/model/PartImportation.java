package model;

import java.util.Date;
import java.util.List;

public class PartImportation {
	private int id;
	private Staff warehouseStaff;
	private Provider provider;
	private Date createdDate;
	private List<PartImportationParts> listPart;
	
	public PartImportation() {
		
	}

	public PartImportation(int id, Staff warehouseStaff, Provider provider, Date createdDate,
			List<PartImportationParts> listPart) {
		super();
		this.id = id;
		this.warehouseStaff = warehouseStaff;
		this.provider = provider;
		this.createdDate = createdDate;
		this.listPart = listPart;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Staff getWarehouseStaff() {
		return warehouseStaff;
	}

	public void setWarehouseStaff(Staff warehouseStaff) {
		this.warehouseStaff = warehouseStaff;
	}

	public Provider getProvider() {
		return provider;
	}

	public void setProvider(Provider provider) {
		this.provider = provider;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public List<PartImportationParts> getListPart() {
		return listPart;
	}

	public void setListPart(List<PartImportationParts> listPart) {
		this.listPart = listPart;
	}

	@Override
	public String toString() {
		return "PartImportation [id=" + id + ", warehouseStaff=" + warehouseStaff + ", provider=" + provider
				+ ", createdDate=" + createdDate + ", listPart=" + listPart + "]";
	}
}

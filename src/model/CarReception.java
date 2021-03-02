package model;

import java.sql.Date;
import java.util.List;

public class CarReception {
	
	private int id;
	private Customer customer;
	private Car car;
	private Date createdDate;
	private Date updatedDate;
	private Staff saleStaff;
	private Staff technicalStaff;
	private List<CarReceptionPart> parts;
	private List<CarReceptionService> services;
	
	public CarReception() {
		
	}

	public CarReception(int id, Customer customer, Car car, Date createdDate, Date updatedDate, Staff saleStaff, 
			Staff technicalStaff, List<CarReceptionPart> parts, List<CarReceptionService> services) {
		this.id = id;
		this.customer = customer;
		this.car = car;
		this.createdDate = createdDate;
		this.updatedDate = updatedDate;
		this.saleStaff = saleStaff;
		this.technicalStaff = technicalStaff;
		this.parts = parts;
		this.services = services;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date created_date) {
		this.createdDate = created_date;
	}
	
	public Date getUpdatedDate() {
		if (updatedDate == null)
			return createdDate;
		return updatedDate;
	}

	public void setUpdatedDate(Date updateDate) {
		this.updatedDate = updateDate;
	}
	
	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}
	
	public Staff getSaleStaff() {
		return saleStaff;
	}

	public void setSaleStaff(Staff saleStaff) {
		this.saleStaff = saleStaff;
	}

	public Staff getTechnicalStaff() {
		return technicalStaff;
	}

	public void setTechnicalStaff(Staff technicalStaff) {
		this.technicalStaff = technicalStaff;
	}

	public List<CarReceptionPart> getParts() {
		return parts;
	}


	public void setParts(List<CarReceptionPart> parts) {
		this.parts = parts;
	}


	public List<CarReceptionService> getServices() {
		return services;
	}


	public void setServices(List<CarReceptionService> services) {
		this.services = services;
	}

	public float getTotalPrice() {
		float sump = 0, sums = 0;
		if (parts != null)
			sump = parts.stream().map(x -> x.getPrice()).reduce((float) 0, (a, b) -> a + b);
		if (services != null) 
			sums = services.stream().map(x -> x.getPrice()).reduce((float) 0, (a, b) -> a + b);
		return sump + sums;
	}
	@Override
	public String toString() {
		return "CarReception [id=" + id + ", customer=" + customer + ", car=" + car + ", createdDate=" + createdDate
				+ ", saleStaff=" + saleStaff + ", technicalStaff=" + technicalStaff + ", parts=" + parts + ", services="
				+ services + "]";
	}
}

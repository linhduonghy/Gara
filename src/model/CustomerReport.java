package model;

import java.sql.Date;

public class CustomerReport {
	
	private Customer customer;
	private Date startDate;
	private Date endDate;
	private float revenue;
	
	public CustomerReport() {
		
	}
	
	public CustomerReport(Customer customer, Date startDate, Date endDate, float revenue) {
		super();
		this.customer = customer;
		this.startDate = startDate;
		this.endDate = endDate;
		this.revenue = revenue;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	
	public float getRevenue() {
		return revenue;
	}

	public void setRevenue(float revenue) {
		this.revenue = revenue;
	}

	@Override
	public String toString() {
		return "CustomerReport [customer=" + customer + ", revenue=" + revenue + "]";
	}
	
	
}

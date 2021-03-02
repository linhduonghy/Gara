package model;

public class Car {
	
	private int id;	
	private Customer customer;
	private String infomation;
	private String status;

	public Car() {
		
	}

	public Car(int id, Customer customer, String infomation, String status) {
		super();
		this.id = id;
		this.customer = customer;
		this.infomation = infomation;
		this.status = status;
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

	public String getInfomation() {
		return infomation;
	}

	public void setInfomation(String infomation) {
		this.infomation = infomation;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	@Override
	public String toString() {
		return "Car [id=" + id + ", customer=" + customer + ", infomation=" + infomation + ", status=" + status
				+ "]";
	}
	
}

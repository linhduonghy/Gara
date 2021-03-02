package model;

public class CarReceptionService{
	
	private CarReception carReception;
	private Service service;
	private int quantity;

	
	public CarReceptionService() {
	}

	public CarReceptionService(CarReception carReception, Service service, int quantity) {
		super();
		this.carReception = carReception;
		this.service = service;
		this.quantity = quantity;
	}

	
	public CarReception getCarReception() {
		return carReception;
	}

	public void setCarReception(CarReception carReception) {
		this.carReception = carReception;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getPrice() {
		return service.getPrice() * quantity;
	}

	@Override
	public String toString() {
		return "CarReceptionService [ service=" + service + ", quantity=" + quantity
				+ "]";
	}
	
}

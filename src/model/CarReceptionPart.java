package model;

public class CarReceptionPart {

	private CarReception carReception;
	private Part part;
	private int quantity;
	
	public CarReceptionPart() {
		
	}

	public CarReceptionPart(CarReception carReception, Part part, int quantity) {
		super();
		this.carReception = carReception;
		this.part = part;
		this.quantity = quantity;
	}

	public CarReception getCarReception() {
		return carReception;
	}

	public void setCarReception(CarReception cr) {
		this.carReception = cr;
	}
	
	public Part getPart() {
		return part;
	}

	public void setPart(Part part) {
		this.part = part;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getPrice() {
		return part.getPrice() * quantity;
	}

	@Override
	public String toString() {
		return "CarReceptionPart [part=" + part + ", quantity=" + quantity + "]";
	}

}

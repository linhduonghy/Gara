package model;

public class PartImportationParts {
	
	private PartImportation partImportation;
	private Part part;
	private int quantity;
	
	public PartImportationParts() {
		// TODO Auto-generated constructor stub
	}

	public PartImportationParts(Part part, PartImportation partImportation, int quantity) {
		super();
		this.part = part;
		this.partImportation = partImportation;
		this.quantity = quantity;
	}

	public Part getPart() {
		return part;
	}

	public void setPart(Part part) {
		this.part = part;
	}

	public PartImportation getPartImportation() {
		return partImportation;
	}

	public void setPartImportation(PartImportation partImportation) {
		this.partImportation = partImportation;
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
		return "PartImportationParts [part=" + part
				+ ", quantity=" + quantity + "]";
	}

	
}

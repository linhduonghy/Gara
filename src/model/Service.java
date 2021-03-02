package model;

public class Service {

	private int id;
	private String name;
	private String description;
	private int yearsWarranty;
	private float price;
	
	public Service() {
		// TODO Auto-generated constructor stub
	}

	public Service(int id, String name, String description, int yearsWarranty, float price) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.yearsWarranty = yearsWarranty;
		this.price = price;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getYearWarranty() {
		return yearsWarranty;
	}

	public void setYearWarranty(int yearsWarranty) {
		this.yearsWarranty = yearsWarranty;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "Service [id=" + id + ", name=" + name + ", description=" + description + ", yearWarranty="
				+ yearsWarranty + ", price=" + price + "]";
	}
	
}

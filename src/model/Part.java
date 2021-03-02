package model;

public class Part {
	
	private int id;
	private String name;
	private String description;
	private int yearsWarranty;
	private float price;
	private int quantityInStock;
	private Provider provider;
	
	public Part() {
		
	}

	public Part(int id, String name, String description, int yearsWarranty, float price, int quantityInStock,Provider provider) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.yearsWarranty = yearsWarranty;
		this.price = price;
		this.quantityInStock = quantityInStock;
		this.provider = provider;
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

	public int getYearsWarranty() {
		return yearsWarranty;
	}

	public void setYearsWarranty(int yearsWarranty) {
		this.yearsWarranty = yearsWarranty;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getQuantityInStock() {
		return quantityInStock;
	}

	public void setQuantityInStock(int quantityInStock) {
		this.quantityInStock = quantityInStock;
	}

	public Provider getProvider() {
		return provider;
	}

	public void setProvider(Provider provider) {
		this.provider = provider;
	}

	@Override
	public String toString() {
		return "Part [id=" + id + ", name=" + name + ", description=" + description + ", yearsWarranty=" + yearsWarranty
				+ ", price=" + price + ", quantityInStock=" + quantityInStock + ", provider=" + provider + "]";
	}
	
}

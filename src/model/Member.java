package model;

import java.sql.Date;

public class Member {
	private int id;
	private String name;
	private String email;
	private String cardNumber;
	private String address;
	private Date dob;
	private String phone;
	
	public Member() {
		
	}
	
	public Member(int id, String name, String email, String cardNumber, String address, 
			Date dob, String phone) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.cardNumber = cardNumber;
		this.address = address;
		this.dob = dob;
		this.phone = phone;
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

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", name=" + name + ", email=" + email + ", cardNumber=" + cardNumber + ", address="
				+ address + ", dob=" + dob + ", phone=" + phone + "]";
	}
}

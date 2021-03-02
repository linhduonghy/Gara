package model;

import java.sql.Date;

public class Customer extends Member{
	
	private boolean vip;
	
	public Customer() {
		
	}
	public Customer(int id, String name, String email, String cardNumber, String address, Date dob,
			String phone, boolean vip) {
		super(id, name, email, cardNumber, address, dob, phone);
		this.vip = vip;
	}
	public Customer(Member member) {
		super(member.getId(), member.getName(), member.getEmail(), 
				member.getCardNumber(), member.getAddress(), member.getDob(), member.getPhone());
	}
	
	public boolean getVip() {
		return vip;
	}
	public void setVip(boolean vip) {
		this.vip = vip;
	}
	@Override
	public String toString() {
		return "Customer [vip=" + vip + ", getId()=" + getId() + ", getName()=" + getName() 
		+ ", getCardNumber()=" + getCardNumber() + ", getAddress()=" + getAddress() 
		+ ", getDob()=" + getDob() + ", getPhone()=" + getPhone() + ", getEmail()=" 
		+ getEmail() + "]";
	}
}

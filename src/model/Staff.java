package model;

import java.sql.Date;

public class Staff extends Member{

	private Role role;
	private String username;
	private String password;
	private String level;
	
	public Staff() {
		super();
	}

	public Staff(int id, String name, String email, String cardNumber, String address, Date dob,
			String phone, Role role, String username, String password, String level) {
		super(id, name, email, cardNumber, address, dob, phone);
		this.role = role;
		this.username = username;
		this.password = password;
		this.level = level;
	}
	
	public Staff(Role role, String username, String password, String level) {
		super();
		this.role = role;
		this.username = username;
		this.password = password;
		this.level = level;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLevel() {
		return level;
	}
	
	public void setLevel(String lv) {
		this.level = lv;
	}
	public void setMember(Member member) {
		setId(member.getId());
		setAddress(member.getAddress());
		setCardNumber(member.getCardNumber());
		setDob(member.getDob());
		setEmail(member.getEmail());
		setName(member.getName());
		setPhone(member.getPhone());
	}
	@Override
	public String toString() {
		return "Staff [role=" + role + ", username=" + username + ", password=" + password  + ", level=" + level
				+ ", getId()=" + getId() + ", getName()=" + getName() + ", getCardNumber()=" + getCardNumber()
				+ ", getAddress()=" + getAddress() + ", getDob()=" + getDob() 
				+ ", getPhone()=" + getPhone() + ", getEmail()=" + getEmail() + "]";
	}

}

package model;

import java.sql.Time;

public class Gara {
	
	private String name;
	private String address;
	private Time open_hour;
	private Time close_hour;
	
	public Gara() {
		// TODO Auto-generated constructor stub
	}

	public Gara(String name, String address, Time open_hour, Time close_hour) {
		super();
		this.name = name;
		this.address = address;
		this.open_hour = open_hour;
		this.close_hour = close_hour;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Time getOpen_hour() {
		return open_hour;
	}

	public void setOpen_hour(Time open_hour) {
		this.open_hour = open_hour;
	}

	public Time getClose_hour() {
		return close_hour;
	}

	public void setClose_hour(Time close_hour) {
		this.close_hour = close_hour;
	}

	@Override
	public String toString() {
		return "Gara [name=" + name + ", address=" + address + ", open_hour=" + open_hour + ", close_hour=" + close_hour
				+ "]";
	}
	
}

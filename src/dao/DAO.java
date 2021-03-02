package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DAO {
	
	public static Connection conn;
	
	String user = "root";
	String pass = "linhdv";
	String dbName = "pttk_garaman";
	String dbClass = "com.mysql.cj.jdbc.Driver";
	
	public DAO() {
		if (conn == null) {
			
			String url = "jdbc:mysql://localhost:3306/"+dbName+
	    			"?useUnicode=true&characterEncoding=utf-8&useSSL=false";
			try {
				Class.forName(dbClass);
	            conn = DriverManager.getConnection(url, user, pass);
			} catch (SQLException | ClassNotFoundException ex) {
				ex.printStackTrace();
			}
		}
	}
	
	public Connection getConnection() {
		return conn;
	}
	public void closeConnection() {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
}

package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Encryption {

	public static String encryptMD5(String message) {
		
		byte[] bytesOfMessage = message.getBytes();
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] digested = md.digest(bytesOfMessage);
			StringBuffer sb = new StringBuffer();
	        for(int i = 0; i < digested.length; i++){
	            sb.append(Integer.toHexString(0xff & digested[i]));
	        }
	        return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public static void main(String[] args) {
		System.out.println(Encryption.encryptMD5("linhdv"));
	}
}

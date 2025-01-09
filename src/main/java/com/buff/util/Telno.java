package com.buff.util;

public class Telno {
    public static String[] splitTel(String phoneNumber) {
        phoneNumber = phoneNumber.replaceAll("[^0-9]", ""); // 숫자만 남기기

        String firstPart = "", secondPart = "", thirdPart = "";

        if (phoneNumber.length() == 11) { // 000-0000-0000
            firstPart = phoneNumber.substring(0, 3);
            secondPart = phoneNumber.substring(3, 7);
            thirdPart = phoneNumber.substring(7, 11);
            
        } else if (phoneNumber.startsWith("02") && phoneNumber.length() == 10) { // 02-0000-0000
            firstPart = phoneNumber.substring(0, 2);
            secondPart = phoneNumber.substring(2, 6);
            thirdPart = phoneNumber.substring(6, 10);
            
        } else if (phoneNumber.length() == 10) { // 000-000-0000
            firstPart = phoneNumber.substring(0, 3);
            secondPart = phoneNumber.substring(3, 6);
            thirdPart = phoneNumber.substring(6, 10);
            
        } else if (phoneNumber.length() == 9) { // 00-000-0000
            firstPart = phoneNumber.substring(0, 2);
            secondPart = phoneNumber.substring(2, 5);
            thirdPart = phoneNumber.substring(5, 9);
        }

        return new String[]{firstPart, secondPart, thirdPart};
    }
    
    public static String splitTelStr(String phoneNumber) {
    	if(phoneNumber == null) {
    		return "-";
    	}
    	phoneNumber = phoneNumber.replaceAll("[^0-9]", ""); // 숫자만 남기기
    	
    	String firstPart = "", secondPart = "", thirdPart = "";
    	
    	if (phoneNumber.length() == 11) { // 000-0000-0000
    		firstPart = phoneNumber.substring(0, 3);
    		secondPart = phoneNumber.substring(3, 7);
    		thirdPart = phoneNumber.substring(7, 11);
    		
    	} else if (phoneNumber.startsWith("02") && phoneNumber.length() == 10) { // 02-0000-0000
    		firstPart = phoneNumber.substring(0, 2);
    		secondPart = phoneNumber.substring(2, 6);
    		thirdPart = phoneNumber.substring(6, 10);
    		
    	} else if (phoneNumber.length() == 10) { // 000-000-0000
    		firstPart = phoneNumber.substring(0, 3);
    		secondPart = phoneNumber.substring(3, 6);
    		thirdPart = phoneNumber.substring(6, 10);
    		
    	} else if (phoneNumber.length() == 9) { // 00-000-0000
    		firstPart = phoneNumber.substring(0, 2);
    		secondPart = phoneNumber.substring(2, 5);
    		thirdPart = phoneNumber.substring(5, 9);
    	}
    	
    	return firstPart+"-"+secondPart+"-"+thirdPart;
    }
}

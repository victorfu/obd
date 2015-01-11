package junit;

import java.util.Date;

public class TestDateTime {
	public static void main(String[] args) {
		String curDatetime = String.format("%tF %<tT", new Date());
	}
	
}

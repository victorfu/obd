package junit;

public class Ppurl {
	public static void main(String[] args) {
		String s = "12.0012312";
		int p = s.indexOf(".");
		System.out.println(p+2);
	}
	
	public String getDecimalPoint(String str)
	{
		String substr = "";
		int p = str.indexOf(".");
		if(p > 0)
		{
			substr = str.substring(0, p+2);
		}
		return substr;
	}
}

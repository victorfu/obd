package junit;


public class JsonData{
	public static void main(String[] args) {
		for(int i=0; i<10; i++)
		{
			double num = Math.random()*0.01;
			String s = String.format("%.3f", num);
			System.out.println(s);
		}
	}
	
}

package junit;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Arrays;

public class JsonData{
	public static void main(String[] args) {
		String s = "09:11:43,09:11:47,09:11:51,09:12:00,09:12:04,09:12:12,09:12:16,09:12:25,09:12:29,09:12:33,09:12:41,09:12:46,09:12:54,09:12:58,09:13:07,09:13:11,09:13:19,09:13:23,09:13:28,09:13:36,09:13:40,09:13:48,09:13:53,09:14:01,09:14:05,09:14:09,09:14:18,09:14:22,09:14:30,09:14:34,09:14:43,09:14:47,09:14:51,09:15:00,09:15:04,09:15:12,09:15:16,09:15:25,09:15:29,09:15:33,09:15:41,09:15:46,09:15:54,09:15:58,09:16:07,09:16:11,09:16:19,09:16:23,09:16:27,09:16:35,09:16:43,09:16:47,09:16:51,09:17:00,09:17:04,09:17:12,09:17:17,09:17:25,09:17:29,09:17:33,09:17:42,09:17:46,09:17:54,09:17:58,09:18:07,09:18:11,09:18:15,09:18:23,09:18:28,09:18:36,09:18:40,09:18:49,09:18:53,09:18:57,09:19:06,09:19:10,09:19:18,09:19:22,09:19:31,09:19:35,09:19:39,09:19:48,09:19:52,09:20:00,09:20:04,09:20:13,09:20:17,09:20:21,09:20:30,09:20:34,09:20:42,09:20:47,09:20:55,09:20:59,09:21:03,09:21:12,09:21:16,09:21:24,09:21:29,09:21:37,09:21:41,09:21:45,09:21:54,09:21:58,09:22:06,09:22:10,09:22:19,09:22:23,09:22:27,09:22:36,09:22:40,09:22:49,09:22:53";
		System.out.println(s.length());
		String[] sa = s.split(",");
		System.out.println(Arrays.asList(sa).size());
		System.loadLibrary("");
	}
	
	private native String show();
	static{
		
	}
}

package cn.voicet.obd.model;

import java.util.List;

public class Series {
	public String name;

	public String type;

	public List<String> data;// 这里要用int 不能用String 不然前台显示不正常（特别是在做数学运算的时候）

	public Series(String name, String type, List<String> data) {
		super();
		this.name = name;
		this.type = type;
		this.data = data;
	}
}

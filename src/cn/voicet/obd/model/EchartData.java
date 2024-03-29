package cn.voicet.obd.model;

import java.util.ArrayList;
import java.util.List;

public class EchartData {
	public List<String> legend = new ArrayList<String>();// 数据分组
	public List<String> category = new ArrayList<String>();// 横坐标
	public List<Series> series = new ArrayList<Series>();// 纵坐标
	public int curid;
	public boolean isgetdata;
	
	public EchartData(List<String> legendList, List<String> categoryList,
			List<Series> seriesList, int curid, boolean isgetdata) {
		super();
		this.legend = legendList;
		this.category = categoryList;
		this.series = seriesList;
		this.curid = curid;
		this.isgetdata = isgetdata;
	}
}

package cn.voicet.common.util;

import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("unchecked")
public class SimplePager 
{
	private int currentPage = 1;	//当前页
	private int totalPage;			//总页数
	private int totalRows;			//总行数
	private int avgRows = 5;		//每页显示数
	private List list;				//原list集合
	private String url;
	
	public SimplePager() 
	{
	}

	public SimplePager(int currentPage, int avgRows, List list, String url) 
	{
		super();
		this.currentPage = currentPage;
		this.avgRows = avgRows;
		this.list = list;
		this.totalRows = list.size();
		this.totalPage = (this.totalRows -1) / this.avgRows + 1;
		this.url = url;
	}
	
	public List getPagerList()
	{
		List newList = new ArrayList();
		for(int i=(currentPage-1)*avgRows; i<totalRows && i<currentPage*avgRows; i++)
		{
			newList.add(list.get(i));
		}
		return newList;
	}

	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public int getAvgRows() {
		return avgRows;
	}
	public void setAvgRows(int avgRows) {
		this.avgRows = avgRows;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}

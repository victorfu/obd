package cn.voicet.obd.form;

public class ProxyForm {
	private int aid;
	private String devno;
	private int ischeck;
	
	/*
	 * save param 
	 */
	private String pname;
	private int ienable;
	private String addr;
	private String telnum;
	private String mobile;
	private String qq;
	private String url;
	private int paid;
	private String company;
	private int mode;
	private int ptype;
	private String sdt;
	private String edt;
	private String img;
	private String money;
	private String email;
	

	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getDevno() {
		return devno;
	}
	public void setDevno(String devno) {
		this.devno = devno;
	}
	public int getIscheck() {
		return ischeck;
	}
	public void setIscheck(int ischeck) {
		this.ischeck = ischeck;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getIenable() {
		return ienable;
	}
	public void setIenable(int ienable) {
		this.ienable = ienable;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTelnum() {
		return telnum;
	}
	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getPaid() {
		return paid;
	}
	public void setPaid(int paid) {
		this.paid = paid;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	public int getPtype() {
		return ptype;
	}
	public void setPtype(int ptype) {
		this.ptype = ptype;
	}
	public String getSdt() {
		return sdt;
	}
	public void setSdt(String sdt) {
		this.sdt = sdt;
	}
	public String getEdt() {
		return edt;
	}
	public void setEdt(String edt) {
		this.edt = edt;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		if(money.length()==0)
		{
			this.money = "0";
		}
		else
		{
			this.money = money;
		}
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}

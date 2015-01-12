package cn.voicet.obd.form;

public class CarForm {
	private int cid;		//车辆编号
	private String devno;	//设备号
	private String pinpai;	//品牌
	private String xinghao;	//型号
	private String buydt;	//购车日期
	private String chepai;	//车牌号码
	private String chejia;	//车架号
	private String fadong;	//发动机编号
	private String color;	//颜色
	private int tip;		//提醒
	private int warn;		//警告
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getDevno() {
		return devno;
	}
	public void setDevno(String devno) {
		this.devno = devno;
	}
	public String getPinpai() {
		return pinpai;
	}
	public void setPinpai(String pinpai) {
		this.pinpai = pinpai;
	}
	public String getXinghao() {
		return xinghao;
	}
	public void setXinghao(String xinghao) {
		this.xinghao = xinghao;
	}
	public String getBuydt() {
		return buydt;
	}
	public void setButdt(String buydt) {
		this.buydt = buydt;
	}
	public String getChepai() {
		return chepai;
	}
	public void setChepai(String chepai) {
		this.chepai = chepai;
	}
	public String getChejia() {
		return chejia;
	}
	public void setChejia(String chejia) {
		this.chejia = chejia;
	}
	public String getFadong() {
		return fadong;
	}
	public void setFadong(String fadong) {
		this.fadong = fadong;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getTip() {
		return tip;
	}
	public void setTip(int tip) {
		this.tip = tip;
	}
	public int getWarn() {
		return warn;
	}
	public void setWarn(int warn) {
		this.warn = warn;
	}
	public void setBuydt(String buydt) {
		this.buydt = buydt;
	}
}
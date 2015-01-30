package cn.voicet.obd.form;

public class WarnForm {
	private String qchepai;	//车牌
	private int type=0;		//告警类型	0:所有告警,7:超速,8:低电压,9:车辆碰撞,11:车辆震动
	private String sdt;
	private String edt;
	
	public String getQchepai() {
		return qchepai;
	}
	public void setQchepai(String qchepai) {
		this.qchepai = qchepai;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
}

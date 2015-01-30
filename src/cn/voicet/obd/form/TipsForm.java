package cn.voicet.obd.form;

public class TipsForm {
	private String qchepai;	//车牌
	private int type = -1;	//提醒类型	-1:所有提醒,2:启动,3:熄火,4:休眠,5:设备掉电,6:协议不支持或通讯失败
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

package cn.voicet.obd.form;

public class HbtForm {
	
	private String curid;
	private String qchepai;
	
	private String chepai;	//车牌
	private int type=0;		//告警类型	0:所有告警,7:超速,8:低电压,9:车辆碰撞,11:车辆震动
	private String sdt;
	private String edt;
	public String getChepai() {
		return chepai;
	}
	public void setChepai(String chepai) {
		if(chepai.length()==0)
		{
			this.chepai = null;
		}
		else
		{
			this.chepai = chepai;
		}
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
	public String getQchepai() {
		return qchepai;
	}
	public void setQchepai(String qchepai) {
		this.qchepai = qchepai;
	}
	public String getCurid() {
		return curid;
	}
	public void setCurid(String curid) {
		this.curid = curid;
	}
}

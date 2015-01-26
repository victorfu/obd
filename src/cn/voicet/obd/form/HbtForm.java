package cn.voicet.obd.form;

public class HbtForm {
	
	private String curid;
	private String qchepai;
	private String qsdttm;
	private String qedttm;
	
	private String chepai;	//车牌
	private int type=0;		//告警类型	0:所有告警,7:超速,8:低电压,9:车辆碰撞,11:车辆震动
	private String sdttm;
	private String edttm;
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
	public String getSdttm() {
		return sdttm;
	}
	public void setSdttm(String sdttm) {
		this.sdttm = sdttm;
	}
	public String getEdttm() {
		return edttm;
	}
	public void setEdttm(String edttm) {
		this.edttm = edttm;
	}
	public String getQchepai() {
		return qchepai;
	}
	public void setQchepai(String qchepai) {
		if(qchepai.length()==0)
		{
			this.qchepai = null;
		}
		else
		{
			this.qchepai = qchepai;
		}
	}
	public String getCurid() {
		return curid;
	}
	public void setCurid(String curid) {
		this.curid = curid;
	}
	public String getQsdttm() {
		return qsdttm;
	}
	public void setQsdttm(String qsdttm) {
		this.qsdttm = qsdttm;
	}
	public String getQedttm() {
		return qedttm;
	}
	public void setQedttm(String qedttm) {
		this.qedttm = qedttm;
	}
}

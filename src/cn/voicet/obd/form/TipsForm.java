package cn.voicet.obd.form;

public class TipsForm {
	private String chepai;	//车牌
	private int type = -1;	//提醒类型	-1:所有提醒,2:启动,3:熄火,4:休眠,5:设备掉电,6:协议不支持或通讯失败
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
}

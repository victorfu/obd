package cn.voicet.obd.form;

public class TripForm {

	private String cid;
	private String sdttm;
	private String edttm;
	private String chepai;
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
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
}

package cn.voicet.obd.form;

public class TripForm {

	private String cid;
	private String sdt;
	private String edt;
	private String chepai;
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
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

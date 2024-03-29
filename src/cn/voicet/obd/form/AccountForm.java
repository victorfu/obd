package cn.voicet.obd.form;

public class AccountForm {
	private int uid;
	private int cid;
	private String devno;
	private int proxyno;	//代理商编号
	private String uname;
	private String uacc;
	
	//edit acc info
	private int ulevel;
	private int aid;
	private String idcard;
	private String idcardtype;
	private String qq;
	private String email;
	private String photo;
	private String addr;
	private String telnum;
	private String mobile;
	private String noteinfo;
	
	
	private int isbind;	//1:分配, 0:取消分配 
	private int parentid;	
	
	private String qacc;	//查询账号
	
	private int ischeck;

	//记录当前页标记
	private String pageflag;
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
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
		if(devno.length()==0)
		{
			this.devno = null;
		}
		else
		{
			this.devno = devno;
		}
	}
	public int getProxyno() {
		return proxyno;
	}
	public void setProxyno(int proxyno) {
		this.proxyno = proxyno;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUacc() {
		return uacc;
	}
	public void setUacc(String uacc) {
		this.uacc = uacc;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getIdcardtype() {
		return idcardtype;
	}
	public void setIdcardtype(String idcardtype) {
		this.idcardtype = idcardtype;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
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
	public String getNoteinfo() {
		return noteinfo;
	}
	public void setNoteinfo(String noteinfo) {
		this.noteinfo = noteinfo;
	}
	public int getUlevel() {
		return ulevel;
	}
	public void setUlevel(int ulevel) {
		this.ulevel = ulevel;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getIsbind() {
		return isbind;
	}
	public void setIsbind(int isbind) {
		this.isbind = isbind;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getQacc() {
		return qacc;
	}
	public void setQacc(String qacc) {
		if(qacc.length()==0)
		{
			this.qacc = null;
		}
		else
		{
			this.qacc = qacc;
		}
	}
	public int getIscheck() {
		return ischeck;
	}
	public void setIscheck(int ischeck) {
		this.ischeck = ischeck;
	}
	public String getPageflag() {
		return pageflag;
	}
	public void setPageflag(String pageflag) {
		this.pageflag = pageflag;
	}
}

package cn.voicet.obd.form;

public class DeviceForm {

	//查询参数
	private String qdevno;
	private String qstate;
	private String qsdt;
	private String qedt;
	
	private String devno;	//设备号
	private String proxy;	//代理商
	private int type;		//设备类型
	private String state="10";	//设备状态
	private String changj;	//厂家
	private String devxh;	//设备型号
	private String valdt;	//有效期
	private String identi;	//识别码
	
	private String qtpname;	//查询参数
	private String tpname;	//设备类型名称
	private String addr;	//地址
	private String telnum;	//电话
	private String mobile;	//手机
	private String qq;		//
	private String email;	//
	private String cjurl;	//厂家网址
	
	private String typeno;	//设备类型编号
	
	private String sdttm;	//开始日期时间
	private String edttm;	//结束日期时间
	//记录当前页标记
	private String pageflag;
	private String devtypepageflag;
	
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
	public String getProxy() {
		return proxy;
	}
	public void setProxy(String proxy) {
		if(proxy.length()==0)
		{
			this.proxy = null;
		}
		else
		{
			this.proxy =proxy;
		}
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getChangj() {
		return changj;
	}
	public void setChangj(String changj) {
		this.changj = changj;
	}
	public String getDevxh() {
		return devxh;
	}
	public void setDevxh(String devxh) {
		this.devxh = devxh;
	}
	public String getValdt() {
		return valdt;
	}
	public void setValdt(String valdt) {
		this.valdt = valdt;
	}
	public String getIdenti() {
		return identi;
	}
	public void setIdenti(String identi) {
		this.identi = identi;
	}
	public String getTypeno() {
		return typeno;
	}
	public void setTypeno(String typeno) {
		this.typeno = typeno;
	}
	public String getTpname() {
		return tpname;
	}
	public void setTpname(String tpname) {
		this.tpname = tpname;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCjurl() {
		return cjurl;
	}
	public void setCjurl(String cjurl) {
		this.cjurl = cjurl;
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
	public String getQdevno() {
		return qdevno;
	}
	public void setQdevno(String qdevno) {
		if(qdevno.length()==0)
		{
			this.qdevno = null;
		}
		else
		{
			this.qdevno = qdevno;
		}
	}
	public String getQstate() {
		return qstate;
	}
	public void setQstate(String qstate) {
		this.qstate = qstate;
	}
	public String getQsdt() {
		return qsdt;
	}
	public void setQsdt(String qsdt) {
		this.qsdt = qsdt;
	}
	public String getQedt() {
		return qedt;
	}
	public void setQedt(String qedt) {
		this.qedt = qedt;
	}
	public String getQtpname() {
		return qtpname;
	}
	public void setQtpname(String qtpname) {
		if(qtpname.length()==0)
		{
			this.qtpname = null;
		}
		else
		{
			this.qtpname = qtpname;
		}
	}
	public String getPageflag() {
		return pageflag;
	}
	public void setPageflag(String pageflag) {
		this.pageflag = pageflag;
	}
	public String getDevtypepageflag() {
		return devtypepageflag;
	}
	public void setDevtypepageflag(String devtypepageflag) {
		this.devtypepageflag = devtypepageflag;
	}
}

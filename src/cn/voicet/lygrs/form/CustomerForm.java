package cn.voicet.lygrs.form;

import java.util.Date;

public class CustomerForm {
	
	/*
	 * 查询参数数组 
	 * 		批次,车龄,出险次数,调查结果,客户姓名,手机,所属话务员
	 */
	private String[] paramarr = {"","","","","","",""};
	private String pino;	//批次号
	private String agtacc;
	private String noteinfo;//备注信息

	private int allocnum;	//分配数
	private int noalloc;	//未分配数
	private String cdt;		//创建日期
	private String agentlist;
	
	//查看页面参数
	private int cid;			//车辆编号
	private String caryear;		//车龄
	private String chuxcs;			//出险次数
	private String chudrq;		//初登日期
	private String baoxdq;		//保险到期
	private String changphm;	//厂牌号码
	private String chephm;		//车牌号码
	private String chejh;		//车架号
	private String fadjbh;		//发动机编号
	
	private String uname;		//客户姓名
	private String idcard;		//身份证号
	private String mobile;		//手机
	private String hometel;		//家庭电话
	private String officetel;	//办公电话
	private String address;		//派送地址
	
	//默认话务员
	private String defaultAgent;
	
	//预约日期时间
	String curDate = String.format("%tF", new Date());
	public String yuydate;
	String curTime = String.format("%tT", new Date());
	public String yuytime;
	private int yuyflag;
	//
	
	//设置隐藏
	private int hideflag;
	
	//记录当前页标记
	private String pageflag;
	
	//查询参数
	private String q_pino;
	private String q_caryear;
	private String q_chuxcs;
	private String q_chephm;
	private String q_uname;
	private String q_mobile;
	private String q_agtacc;
	private int q_state = -1;
	//
	
	//来电弹屏主叫号码 
	private String ani;
	
	private int talkresult;
	private String talkdt;
	private int talkcount;
	
	//appconfig.xml中配置
	private String f;
	
	/**
	 * 2014-12-08 add
	 */
	private String sdt;	//统计开始日期
	private String edt;	//统计结束日期
	
	private int state;
	
	private String baofei;	//保费
	private String baodan;	//保单号
	private String baoend;	//到期日期
	
	private int baomode;	//统计保费模式
	
	private int viewall=0;
	
	public String getPino() {
		return pino;
	}
	public void setPino(String pino) {
		this.pino = pino;
	}
	public String getNoteinfo() {
		return noteinfo;
	}
	public void setNoteinfo(String noteinfo) {
		this.noteinfo = noteinfo;
	}
	
	public String[] getParamarr() {
		return paramarr;
	}
	public void setParamarr(String[] paramarr) {
		this.paramarr = paramarr;
	}
	public int getNoalloc() {
		return noalloc;
	}
	public void setNoalloc(int noalloc) {
		this.noalloc = noalloc;
	}
	public String getCdt() {
		return cdt;
	}
	public void setCdt(String cdt) {
		this.cdt = cdt;
	}
	public int getAllocnum() {
		return allocnum;
	}
	public void setAllocnum(int allocnum) {
		this.allocnum = allocnum;
	}
	public String getAgentlist() {
		return agentlist;
	}
	public void setAgentlist(String agentlist) {
		this.agentlist = agentlist;
	}
	public String getCaryear() {
		return caryear;
	}
	public void setCaryear(String caryear) {
		this.caryear = caryear;
	}
	public String getChuxcs() {
		return chuxcs;
	}
	public void setChuxcs(String chuxcs) {
		this.chuxcs = chuxcs;
	}
	public String getChudrq() {
		return chudrq;
	}
	public void setChudrq(String chudrq) {
		this.chudrq = chudrq;
	}
	public String getBaoxdq() {
		return baoxdq;
	}
	public void setBaoxdq(String baoxdq) {
		this.baoxdq = baoxdq;
	}
	public String getChangphm() {
		return changphm;
	}
	public void setChangphm(String changphm) {
		this.changphm = changphm;
	}
	public String getChephm() {
		return chephm;
	}
	public void setChephm(String chephm) {
		this.chephm = chephm;
	}
	public String getChejh() {
		return chejh;
	}
	public void setChejh(String chejh) {
		this.chejh = chejh;
	}
	public String getFadjbh() {
		return fadjbh;
	}
	public void setFadjbh(String fadjbh) {
		this.fadjbh = fadjbh;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getHometel() {
		return hometel;
	}
	public void setHometel(String hometel) {
		this.hometel = hometel;
	}
	public String getOfficetel() {
		return officetel;
	}
	public void setOfficetel(String officetel) {
		this.officetel = officetel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getYuydate() {
		return yuydate;
	}
	public void setYuydate(String yuydate) {
		this.yuydate = yuydate;
	}
	public String getYuytime() {
		return yuytime;
	}
	public void setYuytime(String yuytime) {
		this.yuytime = yuytime;
	}
	public int getHideflag() {
		return hideflag;
	}
	public void setHideflag(int hideflag) {
		this.hideflag = hideflag;
	}
	public String getAgtacc() {
		return agtacc;
	}
	public void setAgtacc(String agtacc) {
		this.agtacc = agtacc;
	}
	public String getPageflag() {
		return pageflag;
	}
	public void setPageflag(String pageflag) {
		this.pageflag = pageflag;
	}
	public String getQ_pino() {
		return q_pino;
	}
	public void setQ_pino(String qPino) {
		q_pino = qPino;
	}
	public String getQ_caryear() {
		return q_caryear;
	}
	public void setQ_caryear(String qCaryear) {
		q_caryear = qCaryear;
	}
	public String getQ_chuxcs() {
		return q_chuxcs;
	}
	public void setQ_chuxcs(String qChuxcs) {
		q_chuxcs = qChuxcs;
	}
	public String getQ_chephm() {
		return q_chephm;
	}
	public void setQ_chephm(String qChephm) {
		q_chephm = qChephm;
	}
	public String getQ_uname() {
		return q_uname;
	}
	public void setQ_uname(String qUname) {
		q_uname = qUname;
	}
	public String getQ_mobile() {
		return q_mobile;
	}
	public void setQ_mobile(String qMobile) {
		q_mobile = qMobile;
	}
	public String getQ_agtacc() {
		return q_agtacc;
	}
	public void setQ_agtacc(String qAgtacc) {
		q_agtacc = qAgtacc;
	}
	public String getCurDate() {
		return curDate;
	}
	public void setCurDate(String curDate) {
		this.curDate = curDate;
	}
	public String getCurTime() {
		return curTime;
	}
	public void setCurTime(String curTime) {
		this.curTime = curTime;
	}
	public int getYuyflag() {
		return yuyflag;
	}
	public void setYuyflag(int yuyflag) {
		this.yuyflag = yuyflag;
	}
	public String getDefaultAgent() {
		return defaultAgent;
	}
	public void setDefaultAgent(String defaultAgent) {
		this.defaultAgent = defaultAgent;
	}
	public String getAni() {
		return ani;
	}
	public void setAni(String ani) {
		this.ani = ani;
	}
	public int getTalkresult() {
		return talkresult;
	}
	public void setTalkresult(int talkresult) {
		this.talkresult = talkresult;
	}
	public String getTalkdt() {
		return talkdt;
	}
	public void setTalkdt(String talkdt) {
		this.talkdt = talkdt;
	}
	public String getF() {
		return f;
	}
	public void setF(String f) {
		this.f = f;
	}
	public int getTalkcount() {
		return talkcount;
	}
	public void setTalkcount(int talkcount) {
		this.talkcount = talkcount;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getBaofei() {
		return baofei;
	}
	public void setBaofei(String baofei) {
		this.baofei = baofei;
	}
	public String getBaodan() {
		return baodan;
	}
	public void setBaodan(String baodan) {
		this.baodan = baodan;
	}
	public String getBaoend() {
		return baoend;
	}
	public void setBaoend(String baoend) {
		this.baoend = baoend;
	}
	public int getBaomode() {
		return baomode;
	}
	public void setBaomode(int baomode) {
		this.baomode = baomode;
	}
	public int getQ_state() {
		return q_state;
	}
	public void setQ_state(int qState) {
		q_state = qState;
	}
	public int getViewall() {
		return viewall;
	}
	public void setViewall(int viewall) {
		this.viewall = viewall;
	}
}

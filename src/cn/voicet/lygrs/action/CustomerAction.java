package cn.voicet.lygrs.action;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotRoleMenu;
import cn.voicet.common.util.DotSession;
import cn.voicet.lygrs.dao.CustomerDao;
import cn.voicet.lygrs.form.CustomerForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("customerAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class CustomerAction extends BaseAction implements ModelDriven<CustomerForm>{
	private static Logger log = Logger.getLogger(CustomerAction.class);
	@Resource(name=CustomerDao.SERVICE_NAME)
	private CustomerDao customerDao;
	private CustomerForm customerForm = new CustomerForm();
	
	/*
	 * 话务员列表List
	 */
	private List<Map<String, Object>> alist;
	
	public CustomerForm getModel() {
		return customerForm;
	}
	
	/**
	 * 客户资料导入及分配
	 * @return
	 */
	public String importData()
	{
		List<Map<String, Object>> list = customerDao.queryPiNo();
		request.setAttribute("pList", list);
		return "customerImportPage";
	}
	
	/**
	 * 保存批次号
	 * @return
	 * @throws IOException 
	 */
	public String savePiNo() throws IOException
	{
		log.info("pino:"+customerForm.getPino()+", noteinfo:"+customerForm.getNoteinfo());
		customerDao.savePiNo(customerForm);
		response.getWriter().print("ok");
		return null;
	}
	
	/**
	 * 导入资料
	 * @return
	 */
	public String importTelnum()
	{
		log.info("pino:"+customerForm.getPino()+", uploadExcel file:"+uploadExcel);
		//customerDao.batchImportData(uploadExcel, customerForm.getPino());
		customerDao.batchImportDataWithAgent(uploadExcel, customerForm.getPino());
		log.info("import complete");
		return null;
	}
	
	/**
	 * 分配话务员
	 * @return
	 */
	public String alloc()
	{
		List<Map<String, Object>> list = customerDao.queryAgentList();
		request.setAttribute("aList", list);
		return "allocAgentPage";
	}
	
	public String allocAgent()
	{
		log.info("pino:"+customerForm.getPino()+", allocnum:"+customerForm.getAllocnum()+", agentlist:"+customerForm.getAgentlist());
		customerDao.allocAgentByPino(customerForm);
		return null;
	}
	
	public String clearPino()
	{
		customerDao.clearPino(customerForm);
		log.info("清空批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	public String resetFenpei()
	{
		customerDao.resetFenpei(customerForm);
		log.info("重置分配批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	public String deletePici()
	{
		customerDao.deletePici(customerForm);
		log.info("删除批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	
	/*************************************************************************************************/
	/************************************** 客户资料管理页面  ******************************************/
	/*************************************************************************************************/
	/**
	 * 查询客户资料列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(ds.roleID.equals("3"))
		{
			customerForm.setQ_agtacc(ds.agttelnum);
		}
		if(ds.roleID.equals("3"))
		{
			customerForm.setQ_state(-1);
		}
		if(ds.roleID.equals("2"))
		{
			customerForm.setViewall(1);
		}
		log.info("q_pino:"+customerForm.getQ_pino()+", q_caryear:"+customerForm.getQ_caryear()+", q_chuxcs:"+customerForm.getQ_chuxcs()+", q_chephm:"+customerForm.getQ_chephm()+", q_uname:"+customerForm.getQ_uname()+", q_mobile:"+customerForm.getQ_mobile()+", q_agtacc:"+customerForm.getQ_agtacc()+", viewall:"+customerForm.getViewall()+", q_state:"+customerForm.getQ_state());
		List<Map<String, Object>> list = customerDao.queryCustomerInfo(customerForm);
		request.setAttribute("cList", list);
		//
		alist = customerDao.queryAgentList();
		log.info("dfagt:"+ds.dfagt);
		return "customerManagePage";
	}
	
	/**
	 * 导出客户资料列表
	 * @return
	 */
	public String exportAll()
	{
		log.info("pino:"+customerForm.getPino()+", caryear:"+customerForm.getCaryear()+", chuxcs:"+customerForm.getChuxcs()+", chephm:"+customerForm.getChephm()+", uname:"+customerForm.getUname()+", mobile:"+customerForm.getMobile()+", agtacc:"+customerForm.getAgtacc());
		customerDao.exportCustomerData(customerForm, response);
		return null;
	}
	
	public String setDefaultAgent()
	{
		log.info("defaultAgent:"+customerForm.getDefaultAgent());
		DotSession ds = DotSession.getVTSession(request);
		ds.dfagt = customerForm.getDefaultAgent();
		return null;
	}
	
	/**
	 * 删除一条客户资料记录
	 * @return
	 */
	public String deleteCustomerInfo()
	{
		log.info("cid:"+customerForm.getCid());
		customerDao.deleteCustomerInfo(customerForm);
		log.info("delete complete!");
		return null;
	}
	
	/**
	 * 分配客户资料给话务员
	 * @return
	 */
	public String setAgtAlloc()
	{
		DotSession ds = DotSession.getVTSession(request);
		customerForm.setAgtacc(ds.dfagt);
		log.info("cid:"+customerForm.getCid()+", agtacc:"+customerForm.getAgtacc());
		customerDao.allocOneAgent(customerForm);
		return null;
	}
	
	/**
	 * 查询客户资料详情
	 * @return
	 */
	public String viewDetail()
	{
		log.info("cid:"+customerForm.getCid());
		DotSession ds = DotSession.getVTSession(request);
		customerDao.queryDetailInfo(ds, customerForm);
		request.setAttribute("tpMap", ds.map);
		request.setAttribute("callRecordList", ds.list);
		log.info("tpMap:"+ds.map+", list:"+ds.list);
		ds.list=null;
		return "customerDetailPage";
	}
	
	/**
	 * 保存客户资料
	 * @return
	 */
	public String saveCustomerInfo()
	{
		log.info("ids,cid,byear,ot,cp,pp,cfid,eid,odt,edt,uname,crid,mobile,home,office,addr,noteinfo");
		log.info(customerForm.getPino()+","+customerForm.getCid()+","+customerForm.getChuxcs()+","+customerForm.getChephm()+","+customerForm.getChangphm()+","+customerForm.getChejh()+","+customerForm.getFadjbh()+","+customerForm.getChudrq()+","+customerForm.getBaoxdq()+","+customerForm.getUname()+","+customerForm.getIdcard()+","+customerForm.getMobile()+","+customerForm.getHometel()+","+customerForm.getOfficetel()+","+customerForm.getAddress()+","+customerForm.getNoteinfo());
		customerDao.saveCustomerInfo(customerForm);
		rebtnflag = rebtnflag + 1;
		log.info("rebtnflag:"+rebtnflag);
		log.info("save customer info complte!");
		return null;
	}
	
	/**
	 * 设置预约日期时间
	 * @return
	 */
	public String setYuydt()
	{
		log.info("cid:"+customerForm.getCid()+", yuydate:"+customerForm.getYuydate()+", yuytime:"+customerForm.getYuytime());
		customerDao.setYuyueDateTime(customerForm);
		log.info("set yuyue date time complte!");
		return null;
	}
	
	public String tanpin()
	{
		/*
		 * 来电弹屏，根据主叫号码【mobile,hometel,officetel】查询客户资料
		 * 当有多条记录时，只提取第一条记录【peeknum=1】
		 */
		log.info("ani:"+customerForm.getAni()+", cid:"+customerForm.getCid()+", talkdt:"+customerForm.getTalkdt());
		DotSession ds = DotSession.getVTSession(request);
		customerDao.queryTanpinInfo(ds, customerForm);
		
		//
		request.setAttribute("tpMap", ds.map);
		request.setAttribute("callRecordList", ds.list);
		
		//clear
		ds.list=null;
		ds.map=null;
		//
		return "tanpinPage";
	}
	
	/**
	 * 通话小结
	 * @throws IOException 
	 */
	public String saveTalk() throws IOException
	{
		log.info("cid:"+customerForm.getCid()+", talkdt:"+customerForm.getTalkdt()+", talkresult:"+customerForm.getTalkresult()+", content:"+customerForm.getNoteinfo()+"talkcount:"+customerForm.getTalkcount());
		customerDao.saveTalkContent(customerForm);
		JSONObject json = new JSONObject();
		json.put("cid", customerForm.getCid());
		json.put("tr", customerForm.getTalkresult());
		json.put("ct", customerForm.getNoteinfo());
		json.put("count", customerForm.getTalkcount());
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print(json);
		log.info("json:"+json);
		return null;
	}
	
	
	// 下载网络文件
	public void downloadNet() throws MalformedURLException {
		DotSession ds = DotSession.getVTSession(request);
		String wav = request.getParameter("wavFile");
		log.info("wav:"+wav);
		DotRoleMenu roleMenu = (DotRoleMenu)ServletActionContext.getServletContext().getAttribute("vta");
		String ip= roleMenu.getIpWithCTS(ds.curCTS);
		log.info("ip");
		URL url = new URL(ip+"/"+wav);
		log.info("url:"+url);
		String filename = wav.substring(wav.indexOf("talk")+5, wav.length());
		log.info("filename:"+filename);
		try {
			URLConnection conn = url.openConnection();
			InputStream inStream = conn.getInputStream();
			// 设置输出的格式
			response.reset();
			response.setContentType("audio/x-wav");
			response.addHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
			// 循环取出流中的数据
			byte[] b = new byte[1024];
			int len;
			while ((len = inStream.read(b)) > 0)
			response.getOutputStream().write(b, 0, len);
			inStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//myFile属性用来封装上传的文件  
    private File uploadExcel;  
    //myFileContentType属性用来封装上传文件的类型  
    private String uploadExcelContentType;  
    //myFileFileName属性用来封装上传文件的文件名  
    private String uploadExcelFileName;
    //控制文件类型
	@SuppressWarnings("unused")
	private static String[] allowFileType = { "xls", "XLS", "xlsx", "XLSX" };

	public File getUploadExcel() {
		return uploadExcel;
	}
	public void setUploadExcel(File uploadExcel) {
		this.uploadExcel = uploadExcel;
	}
	public String getUploadExcelContentType() {
		return uploadExcelContentType;
	}
	public void setUploadExcelContentType(String uploadExcelContentType) {
		this.uploadExcelContentType = uploadExcelContentType;
	}
	public String getUploadExcelFileName() {
		return uploadExcelFileName;
	}
	public void setUploadExcelFileName(String uploadExcelFileName) {
		this.uploadExcelFileName = uploadExcelFileName;
	}
	//
	private int rebtnflag=1;
	public int getRebtnflag() {
		return rebtnflag;
	}
	public void setRebtnflag(int rebtnflag) {
		this.rebtnflag = rebtnflag;
	}

	public List<Map<String, Object>> getAlist() {
		return alist;
	}
	public void setAlist(List<Map<String, Object>> alist) {
		this.alist = alist;
	}
	
	
	/*************************************************************/
	/********************* 2014-12-08需求补充  ************************/
	/*************************************************************/
	/**
	 * 按座席统计各座席的成功数，失败数(对逾期自动删除的不在统计之列)
	 */
	public String status()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("form cts:"+ds.curCTS+", sdt:"+customerForm.getSdt()+", edt:"+customerForm.getEdt());
		if(null!=customerForm.getSdt() || null!=customerForm.getEdt())
		{
			ds.cursdt = customerForm.getSdt();
			ds.curedt = customerForm.getEdt();
		}
		log.info("ds cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		List<Map<String, Object>> list = customerDao.queryCustomerStatus(ds);
		request.setAttribute("statusList", list);
		return "customerStatusPage";
	}
	
	public String exportStatus()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("form cts:"+ds.curCTS+", sdt:"+customerForm.getSdt()+", edt:"+customerForm.getEdt());
		if(null!=customerForm.getSdt() || null!=customerForm.getEdt())
		{
			ds.cursdt = customerForm.getSdt();
			ds.curedt = customerForm.getEdt();
		}
		log.info("ds cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		//
		customerDao.exportCustomerStatus(response, ds);
		return null;
	}
	
	/**
	 * 客户资料归属查询
	 * 话务人员帐号可以通过车牌号查看库中所有客户的车牌号及归属座席姓名(逾期删除的不在统计之列)
	 */
	public String guishu()
	{
		if(null==customerForm.getQ_chephm() || customerForm.getQ_chephm().equals(""))
		{
			customerForm.setQ_chephm(null);
		}
		log.info("chephm:"+customerForm.getQ_chephm());
		List<Map<String, Object>> list = customerDao.queryCustomerGuishu(customerForm);
		request.setAttribute("gsList", list);
		return "customerGuishuPage";
	}
	
	/**
	 * 工作进展查看
	 * @return
	 */
	public String workjz()
	{
		DotSession ds = DotSession.getVTSession(request);
		customerDao.queryWorkJinZhan(ds);
		request.setAttribute("c1Map", ds.lygagtMap1);
		request.setAttribute("c2Map", ds.lygagtMap2);
		ds.lygagtMap1=null;
		ds.lygagtMap2=null;
		return "workjzPage";
	}
	
	/**
	 * 设置状态
	 * @return
	 */
	public String setCustomerState()
	{
		log.info("cid:"+customerForm.getCid()+", state:"+customerForm.getState());
		customerDao.setCustomerState(customerForm);
		log.info("set state complete!");
		return null;
	}
	
	public String saveBaodan()
	{
		log.info("cid:"+customerForm.getCid()+", baofei:"+customerForm.getBaofei()+", baodan:"+customerForm.getBaodan()+", baoend:"+customerForm.getBaoend());
		customerDao.saveBaodanInfo(customerForm);
		return null;
	}
	
	/**
	 * 管理员保费统计
	 * @return
	 */
	public String baofeianaly()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("form cts:"+ds.curCTS+", sdt:"+customerForm.getSdt()+", edt:"+customerForm.getEdt());
		if(null!=customerForm.getSdt() || null!=customerForm.getEdt())
		{
			ds.cursdt = customerForm.getSdt();
			ds.curedt = customerForm.getEdt();
		}
		log.info("ds cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		log.info("agtacc:"+customerForm.getQ_agtacc()+", baomode:"+customerForm.getBaomode());
		customerDao.queryBaoTotalInfo(ds,customerForm);
		request.setAttribute("baoList", ds.list);
		ds.list=null;
		//放务员列表
		alist = customerDao.queryAgentList();
		return "baofeiTotal";
	}
	
	/**
	 * 查询未接来电
	 * @return
	 */
	public String missCall()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("agttelnum:"+ds.agttelnum);
		List<Map<String, Object>> list = customerDao.queryMissCall(ds);
		request.setAttribute("mcList", list);
		return "missCallPage";
	}
	
	/**
	 * 导出保单汇总信息
	 * @return
	 */
	public String exportBaodan()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("form cts:"+ds.curCTS+", sdt:"+customerForm.getSdt()+", edt:"+customerForm.getEdt());
		if(null!=customerForm.getSdt() || null!=customerForm.getEdt())
		{
			ds.cursdt = customerForm.getSdt();
			ds.curedt = customerForm.getEdt();
		}
		log.info("ds cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		log.info("q_agtacc:"+customerForm.getQ_agtacc()+", baomode:"+customerForm.getBaomode());
		customerDao.exportBaodanTotalInfo(customerForm, response, ds);
		return null;
	}
	
	public String addCallTime()
	{
		log.info("cid:"+customerForm.getCid());
		customerDao.addCallTimes(customerForm);
		return null;
	}
	
	public String changeCallReply()
	{
		log.info("cid:"+customerForm.getCid());
		customerDao.changeCallReply(customerForm);
		return null;
	}
}

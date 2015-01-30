package cn.voicet.obd.action;
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.DeviceDao;
import cn.voicet.obd.form.DeviceForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("deviceAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class DeviceAction extends BaseAction implements ModelDriven<DeviceForm>{
	private static Logger log = Logger.getLogger(DeviceAction.class);
	@Resource(name=DeviceDao.SERVICE_NAME)
	private DeviceDao deviceDao;
	private DeviceForm deviceForm = new DeviceForm();
	
	public DeviceForm getModel() {
		return deviceForm;
	}
	
	/**
	 * 查询设备列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null==deviceForm.getQstate() || deviceForm.getQstate().equals("-1"))
		{
			deviceForm.setState(null);
		}
		else
		{
			deviceForm.setQstate(deviceForm.getQstate());
		}
		if(null!=deviceForm.getQsdt() || null!=deviceForm.getQedt())
		{
			ds.cursdt = deviceForm.getQsdt();
			ds.curedt = deviceForm.getQedt();
		}
		log.info("qdevno:"+deviceForm.getQdevno()+", sdt:"+ds.cursdt+", edt:"+ds.curedt+", qstate:"+deviceForm.getQstate());
		List<Map<String, Object>> list = deviceDao.queryDeviceList(ds, deviceForm);
		request.setAttribute("devList", list);
		//
		List<Map<String, Object>> typeList = deviceDao.queryDeviceTypeList(deviceForm);
		request.setAttribute("typeList", typeList);
		//
		return "devicePage";
	}
	
	/**
	 * 批量导入设备
	 * @return
	 */
	public String importDevice()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("import data start");
		log.info("uid:"+ds.userid+", type:"+deviceForm.getType());
		deviceDao.batchImportData(ds, deviceForm,uploadExcel);
		log.info("import data complete");
		return null;
	}
	
	/************************ upload file props start **************************/
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
	/************************ upload file props end **************************/
	
	/**
	 * 添加设备
	 */
	public String saveDevice()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid:"+ds.userid+", devno:"+deviceForm.getDevno()+",changj:"+deviceForm.getChangj()+", type:"+deviceForm.getType()+", state:"+deviceForm.getState()+", devxy:"+deviceForm.getDevxh()+", valdt:"+deviceForm.getValdt()+", identi:"+deviceForm.getIdenti());
		deviceDao.saveDevice(deviceForm, ds);
		log.info("save device["+deviceForm.getDevno()+"] complete");
		return query();
	}
	
	/**
	 * 删除单条设备记录
	 */
	public String deleteDev()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid:"+ds.userid+", devno:"+deviceForm.getDevno());
		deviceDao.deleteDevice(ds, deviceForm);
		log.info("delete device["+deviceForm.getDevno()+"] complete");
		return null;
	}
	
	
	/**
	 * 设备类型查询
	 */
	public String type()
	{
		log.info("qtpname:"+deviceForm.getQtpname());
		List<Map<String, Object>> list = deviceDao.queryDeviceTypeList(deviceForm);
		request.setAttribute("typeList", list);
		return "deviceTypePage";
	}
	
	/**
	 * 保存设备类型
	 * @return
	 */
	public String saveType()
	{
		log.info("typeno:"+deviceForm.getTypeno()+", tpname:"+deviceForm.getTpname()+", changj:"+deviceForm.getChangj()+", type:"+deviceForm.getType()+", addr:"+deviceForm.getAddr()+", telnum:"+deviceForm.getTelnum()+", mobile:"+deviceForm.getMobile()+", qq:"+deviceForm.getQq()+", email:"+deviceForm.getEmail()+", cjurl:"+deviceForm.getCjurl());	
		deviceDao.saveDeviceType(deviceForm);
		log.info("save device type["+deviceForm.getTypeno()+"] complete!");
		//方便查询
		deviceForm.setTypeno(null);
		return type();
	}
	
	/**
	 * 删除单条设备类型
	 * @return
	 */
	public String deleteType()
	{
		log.info("typeno:"+deviceForm.getTypeno());	
		deviceDao.deleteDeviceType(deviceForm);
		log.info("save device type["+deviceForm.getTypeno()+"] complete!");
		//方便查询
		deviceForm.setTypeno(null);
		return null;
	}
}

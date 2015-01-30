package cn.voicet.obd.action;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.RtDao;
import cn.voicet.obd.form.RtForm;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;

@Controller("rtAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class RtAction extends BaseAction implements ModelDriven<RtForm>{
	private static Logger log = Logger.getLogger(RtAction.class);
	@Resource(name=RtDao.SERVICE_NAME)
	private RtDao rtDao;
	private RtForm rtForm = new RtForm();
	
	public RtForm getModel() {
		return rtForm;
	}
	
	/**
	 * 查询车辆列表
	 * @param deviceForm 
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=rtForm.getSdt() || null!=rtForm.getEdt())
		{
			ds.cursdt = rtForm.getSdt();
			ds.curedt = rtForm.getEdt();
		}
		if(null!=rtForm.getQchepai())
		{
			ds.setCurChepai(rtForm.getQchepai());
		}
		log.info("curChepai:"+ds.getCurChepai()+", cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		List<Map<String, Object>> list = rtDao.queryRtList(ds, rtForm);
		request.setAttribute("rtList", list);
		return "rtPage";
	}
	
	public String monitor()
	{
		return "rtMonitorPage";
	}
	
	boolean isgetdata = false;
	
	public RtAction() {
	}
	
	public void getrtdata() throws IOException
	{
		DotSession ds = DotSession.getVTSession(request);
		//set character
		response.setCharacterEncoding("UTF-8");
		response.setHeader("content-type","text/html;charset=UTF-8");
		//request count
		log.info("requestCount:"+ds.requestCount);
		ds.requestCount++;
		try 
    	{
			log.info("qchepai:"+rtForm.getQchepai());
	        log.info("from request curid:"+rtForm.getCurid());
			//get data
	        Map<String, Object> ecMap = null;
	        ecMap = rtDao.getMonitorDataMap(ds, rtForm);
	        if(null!=ecMap)
	        {
	            String jsonstr = null;
	    		jsonstr = new Gson().toJson(ecMap);
	    		log.info("jsonstr:"+jsonstr);
	    		PrintWriter out = null;
	    		out = response.getWriter();
	    		out.write(jsonstr);
	    		out.flush();
	        }
	        else
	        {
	        	log.warn("map is null");
	        }
    	} 
		catch (Exception e) 
		{
			log.error(e.getMessage());
		}
	}
	
}

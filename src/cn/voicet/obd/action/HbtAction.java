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
import cn.voicet.obd.dao.HbtDao;
import cn.voicet.obd.form.HbtForm;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;

@Controller("hbtAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class HbtAction extends BaseAction implements ModelDriven<HbtForm>{
	private static Logger log = Logger.getLogger(HbtAction.class);
	@Resource(name=HbtDao.SERVICE_NAME)
	private HbtDao hbtDao;
	
	private HbtForm hbtForm = new HbtForm();
	
	public HbtForm getModel() {
		return hbtForm;
	}
	
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=hbtForm.getSdt() || null!=hbtForm.getEdt())
		{
			ds.cursdt = hbtForm.getSdt();
			ds.curedt = hbtForm.getEdt();
		}
		if(null!=hbtForm.getQchepai())
		{
			ds.setCurChepai(hbtForm.getQchepai());
		}
		log.info("uid:"+ds.userid+", curChepai:"+ds.getCurChepai()+", sdt:"+ds.cursdt+", edt:"+ds.curedt);
		List<Map<String, Object>> list = hbtDao.queryHbtList(ds, hbtForm);
		request.setAttribute("hbtList", list);
		return "hbtPage";
	}
	
	public String monitor() throws IOException
	{
		return "hbtMonitorPage";
	}
	
	boolean isgetdata = false;
	//
	public HbtAction() {
	}
	
	public void gethbtdata() throws IOException
	{
		DotSession ds = DotSession.getVTSession(request);
		//set character
		response.setCharacterEncoding("UTF-8");
		response.setHeader("content-type","text/html;charset=UTF-8");
		log.info("requestCount:"+ds.requestCount);
		ds.requestCount++;
		try 
		{
			//request count
			log.info("from request curid:"+hbtForm.getCurid());
			Map<String, Object> ecMap = null;
			ecMap = hbtDao.getMonitorDataMap(ds, hbtForm);
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
			log.error(e+":"+e.getMessage());
		}
	}
}

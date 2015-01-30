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
import cn.voicet.obd.dao.TripDao;
import cn.voicet.obd.form.TripForm;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ModelDriven;

@Controller("tripAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class TripAction extends BaseAction implements ModelDriven<TripForm>{
	private static Logger log = Logger.getLogger(TripAction.class);
	@Resource(name=TripDao.SERVICE_NAME)
	private TripDao tripDao;
	private TripForm tripForm = new TripForm();
	
	public TripForm getModel() {
		return tripForm;
	}
	
	/**
	 * 查询车辆行程列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=tripForm.getSdt() || null!=tripForm.getEdt())
		{
			ds.cursdt = tripForm.getSdt();
			ds.curedt = tripForm.getEdt();
		}
		if(null!=tripForm.getQchepai())
		{
			ds.setCurChepai(tripForm.getQchepai());
		}
		log.info("curChepai:"+ds.getCurChepai()+", cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		List<Map<String, Object>> list = tripDao.queryTripList(ds,tripForm);
		request.setAttribute("tripList", list);
		//
		return "tripPage";
	}
	
	public String viewmap()
	{
		return "mapPage";
	}
	
	public void getmapdata() throws IOException
	{
		log.info("cid:"+tripForm.getCid()+", sdt:"+tripForm.getSdt()+", edt:"+tripForm.getEdt());
		tripForm.setEdt("2015-01-07 10:01:06");
		List<Map<String, Object>> list = tripDao.queryGpsList(tripForm);
		String jsonstr = null;
		jsonstr = new Gson().toJson(list);
		log.info("jsonstr:"+jsonstr);
		PrintWriter out = null;
		out = response.getWriter();
		out.write(jsonstr);
		out.flush();
	}
}

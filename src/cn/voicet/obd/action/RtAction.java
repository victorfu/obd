package cn.voicet.obd.action;
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
		if(null!=rtForm.getSdttm() || null!=rtForm.getEdttm())
		{
			ds.cursdttm = rtForm.getSdttm();
			ds.curedttm = rtForm.getEdttm();
		}
		log.info("chepai:"+rtForm.getChepai()+", cursdttm:"+ds.cursdttm+", curedttm:"+ds.curedttm);
		List<Map<String, Object>> list = rtDao.queryRtList(ds, rtForm);
		request.setAttribute("rtList", list);
		return "rtPage";
	}
	
}

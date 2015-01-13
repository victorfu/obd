package cn.voicet.obd.action;
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
	
	/**
	 * 查询车辆列表
	 * @param deviceForm 
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=hbtForm.getSdttm() || null!=hbtForm.getEdttm())
		{
			ds.cursdttm = hbtForm.getSdttm();
			ds.curedttm = hbtForm.getEdttm();
		}
		log.info("chepai:"+hbtForm.getChepai()+", type:"+hbtForm.getType()+", cursdttm:"+ds.cursdttm+", curedttm:"+ds.curedttm);
		List<Map<String, Object>> list = hbtDao.queryHbtList(ds, hbtForm);
		request.setAttribute("hbtList", list);
		return "hbtPage";
	}
	
}

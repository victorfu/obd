package cn.voicet.obd.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.WarnDao;
import cn.voicet.obd.form.WarnForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("warnAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class WarnAction extends BaseAction implements ModelDriven<WarnForm>{
	private static Logger log = Logger.getLogger(WarnAction.class);
	@Resource(name=WarnDao.SERVICE_NAME)
	private WarnDao warnDao;
	private WarnForm warnForm = new WarnForm();
	
	public WarnForm getModel() {
		return warnForm;
	}
	
	/**
	 * 查询车辆列表
	 * @param deviceForm 
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=warnForm.getSdttm() || null!=warnForm.getEdttm())
		{
			ds.cursdttm = warnForm.getSdttm();
			ds.curedttm = warnForm.getEdttm();
		}
		log.info("chepai:"+warnForm.getChepai()+", type:"+warnForm.getType()+", cursdttm:"+ds.cursdttm+", curedttm:"+ds.curedttm);
		List<Map<String, Object>> list = warnDao.queryWarnList(ds, warnForm);
		request.setAttribute("warnList", list);
		return "warnPage";
	}
	
}

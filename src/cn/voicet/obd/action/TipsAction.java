package cn.voicet.obd.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.TipsDao;
import cn.voicet.obd.form.TipsForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("tipsAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class TipsAction extends BaseAction implements ModelDriven<TipsForm>{
	private static Logger log = Logger.getLogger(TipsAction.class);
	@Resource(name=TipsDao.SERVICE_NAME)
	private TipsDao tipsDao;
	private TipsForm tipsForm = new TipsForm();
	
	public TipsForm getModel() {
		return tipsForm;
	}
	
	/**
	 * 查询车辆列表
	 * @param deviceForm 
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=tipsForm.getSdt() || null!=tipsForm.getEdt())
		{
			ds.cursdt = tipsForm.getSdt();
			ds.curedt = tipsForm.getEdt();
		}
		if(null!=tipsForm.getQchepai())
		{
			ds.setCurChepai(tipsForm.getQchepai());
		}
		log.info("curChepai:"+ds.getCurChepai()+", type:"+tipsForm.getType()+", cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		List<Map<String, Object>> list = tipsDao.queryTipsList(ds, tipsForm);
		request.setAttribute("tipList", list);
		return "tipsPage";
	}
	
}

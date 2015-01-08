package cn.voicet.gc.action;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.gc.dao.SubTelDao;
import cn.voicet.gc.form.SubTelForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("subTelAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class SubTelAction extends BaseAction implements ModelDriven<SubTelForm>{
	private static Logger log = Logger.getLogger(SubTelAction.class);
	@Resource(name=SubTelDao.SERVICE_NAME)
	private SubTelDao subTelDao;
	private SubTelForm subTelForm = new SubTelForm();
	
	public SubTelForm getModel() {
		return subTelForm;
	}
	
	public String list()
	{
		DotSession ds = DotSession.getVTSession(request);
		subTelDao.querySubTelList(ds);
		return "show_subtel";
	}
	
	/**
	 * 添加或更新座席分机
	 * @return
	 */
	public String saveSubTel()
	{
		DotSession ds = DotSession.getVTSession(request);
		subTelDao.saveSubTel(ds, subTelForm);
		return list();
	}
	
	/**
	 * 删除座席分机
	 */
	public String deleteSubTel()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("cts:"+ds.curCTS+", telid:"+subTelForm.getTelid());
		subTelDao.deleteSubTelByTelid(ds, subTelForm);
		log.info("delete subtel ["+subTelForm.getTelid()+"] success!");
		return null;
	}
	
}

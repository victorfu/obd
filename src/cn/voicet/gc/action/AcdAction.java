package cn.voicet.gc.action;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.gc.dao.AcdDao;
import cn.voicet.gc.form.AcdForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("acdAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class AcdAction extends BaseAction implements ModelDriven<AcdForm>{
	private static Logger log = Logger.getLogger(AcdAction.class);
	@Resource(name=AcdDao.SERVICE_NAME)
	private AcdDao acdDao;
	private AcdForm acdForm = new AcdForm();
	
	public AcdForm getModel() {
		return acdForm;
	}
	
	public String list()
	{
		DotSession ds = DotSession.getVTSession(request);
		acdForm.setCts(ds.curCTS);
		acdDao.queryAcdList(ds,acdForm);
		log.info("list2 size:"+ds.list2.size());
		return "show_acd";
	}
	
	/**
	 * 添加或更新业务组
	 * @return
	 */
	public String saveAcd()
	{
		log.info("acdtxt[] length:"+acdForm.getAcdtxt().length);
		DotSession ds = DotSession.getVTSession(request);
		acdDao.saveAcd(ds, acdForm);
		log.info("save acd ["+acdForm.getAcdtxt()[1]+"] success");
		return list();
	}
	
	/**
	 * 删除业务组
	 * @return
	 */
	public String deleteAcd()
	{
		log.info("grpid:"+acdForm.getGrpid());
		acdDao.deleteAcdByGrpid(acdForm);
		log.info("delete acd ["+acdForm.getGrpid()+"] success");
		return null;
	}
	
	/**
	 * 指派任务
	 * @return
	 */
	public String setTask()
	{
		log.info("cts:"+acdForm.getCts()+", grpid:"+acdForm.getGrpid()+", taskid:"+acdForm.getTaskid());
		acdDao.setTaskForAcd(acdForm);
		log.info("set acd task["+acdForm.getTaskid()+"] success");
		return list();
	}
	
}

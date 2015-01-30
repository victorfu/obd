package cn.voicet.obd.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.GroupDao;
import cn.voicet.obd.form.GroupForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("groupAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class GroupAction extends BaseAction implements ModelDriven<GroupForm>{
	private static Logger log = Logger.getLogger(GroupAction.class);
	@Resource(name=GroupDao.SERVICE_NAME)
	private GroupDao groupDao;
	private GroupForm groupForm = new GroupForm();
	
	public GroupForm getModel() {
		return groupForm;
	}
	
	/**
	 * 查询车辆列表
	 * @param deviceForm 
	 * @return
	 */
	public String query()
	{
		log.info("flag:"+groupForm.getFlag());
		DotSession ds = DotSession.getVTSession(request);
		if(null!=groupForm.getSdt() || null!=groupForm.getEdt())
		{
			ds.cursdt = groupForm.getSdt();
			ds.curedt = groupForm.getEdt();
		}
		if(null!=groupForm.getQchepai())
		{
			ds.setCurChepai(groupForm.getQchepai());
		}
		log.info("curChepai:"+ds.getCurChepai()+", cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		List<Map<String, Object>> list = groupDao.queryGroupList(ds, groupForm);
		request.setAttribute("groupList", list);
		if(groupForm.getFlag()==1)
		{
			return "groupPage1";
		}
		else if(groupForm.getFlag()==2)
		{
			return "groupPage2";
		}
		else if(groupForm.getFlag()==3)
		{
			return "groupPage3";
		}
		else if(groupForm.getFlag()==4)
		{
			return "groupPage4";
		}
		else
		{
			return ERROR;
		}
	}
	
}

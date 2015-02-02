package cn.voicet.common.action;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.listener.SingleLoginListener;
import cn.voicet.common.util.DotRoleMenu;

@Controller("indexAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class IndexAction extends BaseAction{

	private static Logger log = Logger.getLogger(IndexAction.class);
	public String index(){
		String xmlFilePath = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/appconfig-obd.xml");
		DotRoleMenu roleMenu = (DotRoleMenu)ServletActionContext.getServletContext().getAttribute("vta");
		if (roleMenu == null) {
			roleMenu = new DotRoleMenu();
			roleMenu.loadInfoFromXML(xmlFilePath);
			ServletActionContext.getServletContext().setAttribute("vta", roleMenu);
		}
		log.info("to login");

		boolean b = SingleLoginListener.isOnline(request.getSession());
		System.out.println("b1:"+b);
		if(b)
		{
			return "show_home";
		}
		return "show_login";
	}
}

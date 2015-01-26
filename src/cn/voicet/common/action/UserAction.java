package cn.voicet.common.action;
import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.dao.UserDao;
import cn.voicet.common.form.UserForm;
import cn.voicet.common.util.DotSession;

import com.opensymphony.xwork2.ModelDriven;

@Controller("userAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class UserAction extends BaseAction implements ModelDriven<UserForm>{
	private static Logger log = Logger.getLogger(UserAction.class);
	@Resource(name=UserDao.SERVICE_NAME)
	private UserDao userDao;
	private UserForm userForm = new UserForm();
	
	public UserForm getModel() {
		return userForm;
	}
	
	public String ajaxlogin(){
		log.info("account:"+userForm.getAccount()+", password:"+userForm.getPassword()+", vercode:"+userForm.getVercode());
		JSONObject json = new JSONObject();
		if (request.getSession().getAttribute("vts")==null) {
			DotSession ds = new DotSession();
			request.getSession().setAttribute("vts", ds);
		}
		DotSession ds=DotSession.getVTSession(request);
		
		Map<String, Object> map = userDao.userLogin(userForm);
		log.info("user login map: "+map);
		//
		ds.userid = Integer.valueOf((String) map.get("uid"));
		ds.roleID=(String) map.get("lev");
		ds.username=(String) map.get("name");
		//
		ds.password = userForm.getPassword();
		ds.account=userForm.getAccount();
		//
		log.info("rand:"+request.getSession().getAttribute("rand"));
		log.info("roleID:"+ds.roleID);
		//
		if(ds.roleID.equals("1") || ds.roleID.equals("2") || ds.roleID.equals("3") || ds.roleID.equals("4"))
		{
			json.put("status", "ok");
			log.info("login complete");
		}
		else
		{
			json.put("status", "err");
			log.info("login failure");
		}
		if(null!=request.getSession().getAttribute("rand") && !userForm.getVercode().trim().equals((String) request.getSession().getAttribute("rand")))
		{
			json.put("status", "vercodeerror");
		}
		log.info("json:"+json);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
			response.getWriter().flush();
		} catch (IOException e) {
			log.error(e);
		}
		return null;
	}

	public String home(){
		log.info("has login");
		return "show_home";
	}
	
	/**
	 * update password
	 * @return
	 * @throws IOException
	 */
	public String updatePwd() throws IOException
	{
		DotSession ds=DotSession.getVTSession(request);
		log.info("oldpwd:"+userForm.getOldpwd()+", newpwd:"+userForm.getNewpwd());
		
		boolean bool = userDao.updateUserPassword(ds, userForm);
		log.info("bool:"+bool);
		if(bool)
		{
			ds.password = userForm.getNewpwd();
			log.info("update after password:"+ds.password);
		}
		response.getWriter().print(bool);
		return null;
	}
	
	/** 注销  */
	public String logout() {
		DotSession ds=DotSession.getVTSession(request);
		ds.clear();
		request.getSession().invalidate();
		return null;
	}
	
	/**
	 * 注册页面
	 * @return
	 */
	public String register()
	{
		return "userRegPage";
	}
	
	public String reg() throws IOException
	{
		log.info("account:"+userForm.getAccount()+", password:"+userForm.getPassword()+", devno:"+userForm.getDevno());
		String res = userDao.registerUser(userForm);
		log.info("res:"+res);
		response.getWriter().write(res);
		return null;
	}
	
	public String regSucc()
	{
		return "regSuccessPage";
	}
	
	public String ansyUserName() throws IOException
	{
		log.info("account:"+userForm.getAccount());
		String b = userDao.ansyUserName(userForm);
		log.info("b:"+b);
		response.getWriter().write(b);
		return null;
	}
	
}

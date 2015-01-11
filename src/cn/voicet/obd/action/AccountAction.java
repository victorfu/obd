package cn.voicet.obd.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.AccountDao;
import cn.voicet.obd.form.AccountForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("accountAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class AccountAction extends BaseAction implements ModelDriven<AccountForm>{
	private static Logger log = Logger.getLogger(AccountAction.class);
	@Resource(name=AccountDao.SERVICE_NAME)
	private AccountDao accountDao;
	private AccountForm accountForm = new AccountForm();
	
	public AccountForm getModel() {
		return accountForm;
	}
	
	/**
	 * 查询用户列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		List<Map<String, Object>> list = accountDao.queryAccountList(ds, accountForm);
		request.setAttribute("accList", list);
		//
		return "accountPage";
	}
	
	public String viewCar()
	{
		DotSession ds = DotSession.getVTSession(request);
		List<Map<String, Object>> list = accountDao.queryCarList(ds, accountForm);
		request.setAttribute("carList", list);
		return "accountCarPage";
	}
	
	public String fenpei()
	{
		log.info("uid:"+accountForm.getUid()+", cid:"+accountForm.getCid()+", devno:"+accountForm.getDevno());
		accountDao.queryCarList(accountForm);
		return viewCar();
	}
}

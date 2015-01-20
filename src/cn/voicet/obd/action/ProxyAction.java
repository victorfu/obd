package cn.voicet.obd.action;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.ProxyDao;
import cn.voicet.obd.form.ProxyForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("proxyAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class ProxyAction extends BaseAction implements ModelDriven<ProxyForm>{
	private static Logger log = Logger.getLogger(ProxyAction.class);
	@Resource(name=ProxyDao.SERVICE_NAME)
	private ProxyDao proxyDao;
	private ProxyForm proxyForm = new ProxyForm();
	
	public ProxyForm getModel() {
		return proxyForm;
	}
	
	/**
	 * 查询设备列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid:"+ds.userid+", qpname:"+proxyForm.getQpname());
		List<Map<String, Object>> list = proxyDao.queryProxyList(ds, proxyForm);
		request.setAttribute("proxyList", list);
		//
		return "proxyPage";
	}
	
	/**
	 * 获取设备列表
	 * @return
	 */
	public String finddev()
	{
		DotSession ds = DotSession.getVTSession(request);
		List<Map<String, Object>> list = proxyDao.queryDeviceList(ds, proxyForm);
		request.setAttribute("devList", list);
		//
		return "devPage";
	}
	
	public String selectDev()
	{
		proxyDao.selectDevice(proxyForm);
		return null;
	}
	
	public String saveProxy()
	{
		log.info("aid:"+proxyForm.getAid()+", pname:"+proxyForm.getPname()+", ienable:"+proxyForm.getIenable()+", addr:"+proxyForm.getAddr()+", tel:"+proxyForm.getTelnum()+", mobile:"+proxyForm.getMobile()+", qq:"+proxyForm.getQq()+", url:"+proxyForm.getUrl()+", paid:"+proxyForm.getPaid()+", company"+proxyForm.getCompany()+", mode:"+proxyForm.getMode()+", typ:"+proxyForm.getPtype()+", stdt:"+proxyForm.getSdt()+", etdt:"+proxyForm.getEdt()+", pic:"+proxyForm.getImg()+", mony:"+proxyForm.getMoney()+", mail:"+proxyForm.getEmail());
		proxyDao.saveProxy(proxyForm);
		return query();
	}
	
	public String deleteProxy()
	{
		log.info("aid:"+proxyForm.getAid());
		proxyDao.deleteProxy(proxyForm);
		return null;
	}
}

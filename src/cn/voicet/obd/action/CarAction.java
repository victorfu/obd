package cn.voicet.obd.action;
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.obd.dao.CarDao;
import cn.voicet.obd.form.CarForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("carAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class CarAction extends BaseAction implements ModelDriven<CarForm>{
	private static Logger log = Logger.getLogger(CarAction.class);
	@Resource(name=CarDao.SERVICE_NAME)
	private CarDao carDao;
	private CarForm carForm = new CarForm();
	
	public CarForm getModel() {
		return carForm;
	}
	
	/**
	 * 查询车辆列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		List<Map<String, Object>> list = carDao.queryCarList(ds, carForm);
		request.setAttribute("carList", list);
		//
		List<Map<String, Object>> devlist = carDao.queryUsableDeviceList(ds);
		request.setAttribute("devList", devlist);
		//
		return "carPage";
	}
	
	public String saveCar()
	{
		log.info("cid:"+carForm.getCid()+", devno:"+carForm.getDevno()+", pinpai:"+carForm.getPinpai()+", xinghao:"+carForm.getXinghao()+", buydt:"+carForm.getBuydt()+", chepai:"+carForm.getChepai()+", chejia:"+carForm.getChejia()+", fadong:"+carForm.getFadong()+", color:"+carForm.getColor()+", tip:"+carForm.getTip()+", warn:"+carForm.getWarn());
		DotSession ds = DotSession.getVTSession(request);
		carDao.saveCar(ds, carForm);
		return query();
	}
	
	public String deleteCar()
	{
		DotSession ds = DotSession.getVTSession(request);
		carDao.deleteCar(ds, carForm);
		return null;
	}
	
	public String unbindDev()
	{
		DotSession ds = DotSession.getVTSession(request);
		carDao.unbindDev(ds, carForm);
		return null;
	}
}
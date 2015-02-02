package cn.voicet.obd.action;
import java.io.IOException;
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
		if(null!=carForm.getQchepai())
		{
			ds.setCurChepai(carForm.getQchepai());
		}
		log.info("curChepai:"+ds.getCurChepai());
		List<Map<String, Object>> list = carDao.queryCarList(ds, carForm);
		request.setAttribute("carList", list);
		//
		log.info("pageflag:"+carForm.getPageflag());
		return "carPage";
	}
	
	public String checkEnableDev() throws IOException
	{
		boolean isdevenable = carDao.checkEnableDev(carForm);
		log.info("isdevenable:"+isdevenable);
		response.getWriter().print(isdevenable);
		return null;
	}
	
	/**
	 * 修改车辆前，获取可用的设备号
	 * @return
	 * @throws IOException 
	 */
	public String getEnableDevno() throws IOException
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid:"+ds.userid+", cid:"+carForm.getCid());
		StringBuffer devnoStr = carDao.getEnableDevno(ds, carForm);
		log.info("devnoStr:"+devnoStr);
		response.getWriter().print(devnoStr);
		return null;
	}
	
	public String saveCar() throws IOException
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid"+ds.userid+", cid:"+carForm.getCid()+", devno:"+carForm.getDevno()+", pinpai:"+carForm.getPinpai()+", xinghao:"+carForm.getXinghao()+", buydt:"+carForm.getBuydt()+", chepai:"+carForm.getChepai()+", chejia:"+carForm.getChejia()+", fadong:"+carForm.getFadong()+", color:"+carForm.getColor()+", tip:"+carForm.getTip()+", warn:"+carForm.getWarn());
		String flag = carDao.saveCar(ds, carForm);
		log.info("flag:"+flag);
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(flag);
		return null;
	}
	
	public String deleteCar()
	{
		DotSession ds = DotSession.getVTSession(request);
		log.info("uid:"+ds.userid+", cid: "+ carForm.getCid());
		carDao.deleteCar(ds, carForm);
		log.info("delete ["+ carForm.getCid()+"] complete");
		return null;
	}
	
	public String unbindDev()
	{
		log.info("cid:"+carForm.getCid()+", devno:"+carForm.getDevno());
		DotSession ds = DotSession.getVTSession(request);
		carDao.unbindDev(ds, carForm);
		return null;
	}
	
	
	/**
	 * 车辆定位监控
	 */
	public String monitor()
	{
		return "carMonitorPage";
	}
	
	/**
	 * 查询需要监测的车辆
	 * @return
	 */
	public String querymonitorcar()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=carForm.getQchepai())
		{
			ds.setCurChepai(carForm.getQchepai());
		}
		log.info("uid:"+ds.userid+", curChepai:"+ds.getCurChepai());
		List<Map<String, Object>> list = carDao.queryCarList(ds, carForm);
		request.setAttribute("carList", list);
		return "carMonitorDataPage";
	}
	
	/**
	 * 车辆行程统计
	 * @return
	 */
	public String triptotal()
	{
		DotSession ds = DotSession.getVTSession(request);
		if(null!=carForm.getSdt() || null!=carForm.getEdt())
		{
			ds.cursdt = carForm.getSdt();
			ds.curedt = carForm.getEdt();
		}
		if(null!=carForm.getQchepai())
		{
			ds.setCurChepai(carForm.getQchepai());
		}
		log.info("userid:"+ds.userid+", curChepai:"+ds.getCurChepai()+", cursdt:"+ds.cursdt+", curedt:"+ds.curedt);
		String tripData = carDao.queryTripTotal(ds, carForm);
		log.info("tripData:"+tripData);
		request.setAttribute("tripData", "11, 20, 13, 40, 15, 60,17,80,19,10,17,42,23,64,15");
		return "carTripTotalPage";
	}
}

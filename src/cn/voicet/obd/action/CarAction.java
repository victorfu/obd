package cn.voicet.obd.action;
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
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
	 * 查询设备列表
	 * @return
	 */
	public String query()
	{
		List<Map<String, Object>> list = carDao.queryCarList(carForm);
		request.setAttribute("carList", list);
		//
		return "carPage";
	}
}

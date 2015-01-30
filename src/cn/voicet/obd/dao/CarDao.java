package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.CarForm;

public interface CarDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.CarDaoImpl";
	List<Map<String, Object>> queryCarList(DotSession ds, CarForm carForm);
	String saveCar(DotSession ds, CarForm carForm);
	void deleteCar(DotSession ds, CarForm carForm);
	StringBuffer getEnableDevno(DotSession ds, CarForm carForm);
	void unbindDev(DotSession ds, CarForm carForm);
	String queryTripTotal(DotSession ds, CarForm carForm);
	boolean checkEnableDev(CarForm carForm);
}

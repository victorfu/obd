package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.CarForm;

public interface CarDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.CarDaoImpl";
	List<Map<String, Object>> queryCarList(DotSession ds, CarForm carForm);
	void saveCar(DotSession ds, CarForm carForm);
	void deleteCar(DotSession ds, CarForm carForm);
	List<Map<String, Object>> queryUsableDeviceList(DotSession ds);
	void unbindDev(DotSession ds, CarForm carForm);
}
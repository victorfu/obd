package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.obd.form.CarForm;

public interface CarDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.CarDaoImpl";
	List<Map<String, Object>> queryCarList(CarForm carForm);
}

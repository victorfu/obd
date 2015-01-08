package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.TripForm;

public interface TripDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.TripDaoImpl";
	List<Map<String, Object>> queryTripList(DotSession ds, TripForm tripForm);
	List<Map<String, Object>> queryGpsList(TripForm tripForm);
}

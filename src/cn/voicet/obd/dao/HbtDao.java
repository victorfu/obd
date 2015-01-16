package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.HbtForm;

public interface HbtDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.HbtDaoImpl";
	List<Map<String, Object>> queryHbtList(DotSession ds, HbtForm hbtForm);
	List<Map<String, Object>> queryCarList(DotSession ds, HbtForm hbtForm);
	Map<String, Object> getMonitorDataMap(DotSession ds, HbtForm hbtForm);
}

package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.RtForm;

public interface RtDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.RtDaoImpl";
	List<Map<String, Object>> queryRtList(DotSession ds, RtForm rtForm);
	Map<String, Object> getMonitorDataMap(DotSession ds, RtForm rtForm);
}

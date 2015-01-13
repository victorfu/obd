package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.WarnForm;

public interface WarnDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.WarnDaoImpl";
	List<Map<String, Object>> queryWarnList(DotSession ds, WarnForm warnForm);
}

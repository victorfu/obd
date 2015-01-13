package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.GroupForm;

public interface GroupDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.GroupDaoImpl";
	List<Map<String, Object>> queryGroupList(DotSession ds, GroupForm GroupForm);
}

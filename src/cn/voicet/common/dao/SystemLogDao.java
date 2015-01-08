package cn.voicet.common.dao;

import cn.voicet.common.form.SystemLogForm;
import cn.voicet.common.util.DotSession;

public interface SystemLogDao{
	public final static String SERVICE_NAME = "cn.voicet.common.dao.impl.SystemLogDaoImpl";
	int findLogTotalPage(DotSession ds, SystemLogForm systemLogForm);
	void findLogInfoList(DotSession ds, SystemLogForm systemLogForm);
}

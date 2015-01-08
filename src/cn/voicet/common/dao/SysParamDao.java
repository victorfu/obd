package cn.voicet.common.dao;

import cn.voicet.common.util.DotSession;

public interface SysParamDao {
	public final static String SERVICE_NAME = "cn.voicet.common.dao.impl.SysParamDaoImpl";
	String getAni();
	int getMaxwait();
	void saveParam(DotSession ds, String ani, int maxwait);
}

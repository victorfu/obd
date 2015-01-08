package cn.voicet.gc.dao;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.AcdForm;

public interface AcdDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.AcdDaoImpl";
	void queryAcdList(DotSession ds, AcdForm acdForm);
	void queryAcdAnalyList(DotSession ds);
	void saveAcd(DotSession ds, AcdForm acdForm);
	void deleteAcdByGrpid(AcdForm acdForm);
	void setTaskForAcd(AcdForm acdForm);
	void getAcdMonitorList(DotSession ds);
}

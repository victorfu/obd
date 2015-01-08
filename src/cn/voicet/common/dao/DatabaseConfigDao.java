package cn.voicet.common.dao;

import cn.voicet.common.util.DotSession;

public interface DatabaseConfigDao {
	public final static String SERVICE_NAME = "cn.voicet.commom.dao.impl.DatabaseConfigDaoImpl";
	void databaseInfo(DotSession ds);
	void emptyDatabase(DotSession ds);
	void backupDatabase(DotSession ds, String defbackupfilename);
}

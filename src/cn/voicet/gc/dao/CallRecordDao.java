package cn.voicet.gc.dao;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.CallRecordForm;

public interface CallRecordDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.CallRecordDaoImpl";
	void queryCallRecordList(DotSession ds, CallRecordForm callRecordForm);
}

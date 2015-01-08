package cn.voicet.gc.dao;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.NtsForm;

public interface NtsDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.NtsDaoImpl";
	void queryNtsList(DotSession ds, NtsForm ntsForm);
	void saveNts(DotSession ds, NtsForm ntsForm);
	void deleteNts(NtsForm ntsForm);
}

package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.AccountForm;

public interface AccountDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.AccountDaoImpl";
	List<Map<String, Object>> queryAccountList(DotSession ds, AccountForm accountForm);
	List<Map<String, Object>> queryCarList(DotSession ds,
			AccountForm accountForm);
	void queryCarList(AccountForm accountForm);
}

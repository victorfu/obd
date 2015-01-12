package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.TipsForm;

public interface TipsDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.TipsDaoImpl";
	List<Map<String, Object>> queryTipsList(DotSession ds, TipsForm tipsForm);
}

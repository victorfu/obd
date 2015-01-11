package cn.voicet.obd.dao;

import java.util.List;
import java.util.Map;

import cn.voicet.common.util.DotSession;
import cn.voicet.obd.form.ProxyForm;

public interface ProxyDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.ProxyDaoImpl";
	List<Map<String, Object>> queryProxyList(DotSession ds, ProxyForm proxyForm);
	List<Map<String, Object>> queryDeviceList(DotSession ds, ProxyForm proxyForm);
	void selectDevice(ProxyForm proxyForm);
	void saveProxy(ProxyForm proxyForm);
	void deleteProxy(ProxyForm proxyForm);
}

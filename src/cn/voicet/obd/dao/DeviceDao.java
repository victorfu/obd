package cn.voicet.obd.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import cn.voicet.obd.form.DeviceForm;

public interface DeviceDao {
	public static final String SERVICE_NAME = "cn.voicet.obd.dao.impl.DeviceDaoImpl";
	List<Map<String, Object>> queryDeviceList(DeviceForm deviceForm);
	void batchImportData(File uploadExcel);
	void saveDevice(DeviceForm deviceForm);
	void deleteDevice(DeviceForm deviceForm);
	
	//设备类型
	List<Map<String, Object>> queryDeviceTypeList(DeviceForm deviceForm);
	void saveDeviceType(DeviceForm deviceForm);
	void deleteDeviceType(DeviceForm deviceForm);
}

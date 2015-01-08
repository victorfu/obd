package cn.voicet.obd.dao.impl;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.impl.BaseDaoImpl;
import cn.voicet.common.util.VTJime;
import cn.voicet.obd.dao.CarDao;
import cn.voicet.obd.form.CarForm;
import cn.voicet.obd.form.DeviceForm;

@Repository(CarDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class CarDaoImpl extends BaseDaoImpl implements CarDao {
	public static final Logger log = Logger.getLogger(CarDaoImpl.class);

	public List<Map<String, Object>> queryCarList(CarForm carForm) {
		log.info("sp:web_user_car_query(?)");
		//return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_user_car_query(?)}", new CallableStatementCallback() {
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("select * from tb_card", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//cs.setString("cid", null);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				List<Object> list = new ArrayList<Object>();
				if(rs!=null){
					while (rs.next()) {
						 map = new HashMap<String, Object>();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}
	
	public void deleteDeviceType(final DeviceForm deviceForm) {
		log.info("sp:web_dev_Type_Del(?)");
		this.getJdbcTemplate().execute("{call web_dev_Type_Del(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("vid", deviceForm.getTypeno());
				cs.execute();
				return null;
			}
		});
	}

}

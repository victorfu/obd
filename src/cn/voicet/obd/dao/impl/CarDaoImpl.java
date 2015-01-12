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
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.VTJime;
import cn.voicet.obd.dao.CarDao;
import cn.voicet.obd.form.CarForm;
import cn.voicet.obd.form.DeviceForm;

@Repository(CarDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class CarDaoImpl extends BaseDaoImpl implements CarDao {
	public static final Logger log = Logger.getLogger(CarDaoImpl.class);

	public List<Map<String, Object>> queryCarList(final DotSession ds, final CarForm carForm) {
		log.info("sp:web_user_car_query(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_user_car_query(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
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
	
	public void saveCar(final DotSession ds, final CarForm carForm) {
		//
		log.info("sp:web_user_car_update(?,?,?,?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_user_car_update(?,?,?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setInt("cid", carForm.getCid());
				cs.setString("dsn", carForm.getDevno());
				cs.setString("pp", carForm.getPinpai());
				cs.setString("xh", carForm.getXinghao());
				cs.setString("gcdt", carForm.getBuydt());
				cs.setString("cph", carForm.getChepai());
				cs.setString("cjh", carForm.getChejia());
				cs.setString("fdjh", carForm.getFadong());
				cs.setString("ys", carForm.getColor());
				cs.setInt("tx", carForm.getTip());
				cs.setInt("gj", carForm.getWarn());
				cs.execute();
				return null;
			}
		});
	}
	
	public void deleteCar(final DotSession ds, final CarForm carForm) {
		log.info("sp:web_user_car_remove(?,?)");
		this.getJdbcTemplate().execute("{call web_user_car_remove(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setInt("cid", carForm.getCid());
				cs.execute();
				return null;
			}
		});
	}

	public List<Map<String, Object>> queryUsableDeviceList(final DotSession ds) {
		log.info("sp:web_user_car_Dev_Available(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_user_car_Dev_Available(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
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

	public void unbindDev(final DotSession ds, final CarForm carForm) {
		log.info("sp:web_dev_car_share_remove(?,?)");
		this.getJdbcTemplate().execute("{call web_dev_car_share_remove(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("cid", carForm.getCid());
				cs.setString("dsn", carForm.getDevno());
				cs.execute();
				return null;
			}
		});
	}

}

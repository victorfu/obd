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
import cn.voicet.obd.dao.HbtDao;
import cn.voicet.obd.form.HbtForm;

@Repository(HbtDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class HbtDaoImpl extends BaseDaoImpl implements HbtDao {
	public static final Logger log = Logger.getLogger(HbtDaoImpl.class);

	public List<Map<String, Object>> queryHbtList(final DotSession ds, final HbtForm hbtForm) {
		log.info("sp:dev_Data_HBT_Query(?,?,?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call dev_Data_HBT_Query(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setString("cph", ds.getCurChepai());
				cs.setString("sdt", ds.cursdt);
				cs.setString("edt", ds.curedt);
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

	public List<Map<String, Object>> queryCarList(final DotSession ds, final HbtForm hbtForm) {
		log.info("sp:web_car_query(?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_car_query(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setString("cph", hbtForm.getQchepai());
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

	public Map<String, Object> getMonitorDataMap(final DotSession ds, final HbtForm hbtForm) {
		log.info("sp:Car_Monitoring_HBT(?,?)");
		return (Map<String, Object>)this.getJdbcTemplate().execute("{call Car_Monitoring_HBT(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("cph", hbtForm.getQchepai());
				cs.setString("rid", hbtForm.getCurid());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> ecMap = null;
				if(rs!=null){
					while (rs.next()) {
						ecMap = new HashMap<String, Object>();
						ecMap.put("curid", rs.getString("id"));
						ecMap.put("rec",rs.getString("recvdate").substring(11,19));
						ecMap.put("tot",rs.getString("totallgnition"));
						ecMap.put("acct",rs.getString("accumulativetime"));
						ecMap.put("acci",rs.getString("accumulativeidletime"));
						ecMap.put("aveh",rs.getString("averageheating"));
						ecMap.put("aves",rs.getString("averagespeed"));
						ecMap.put("maxs",rs.getString("maxspeed"));
						ecMap.put("hig",rs.getString("highestspeed"));
						ecMap.put("acce",rs.getString("acceleration"));
						ecMap.put("tde",rs.getString("tdeceleration"));
						ecMap.put("tsw",rs.getString("tswerve"));
						//
			    		if(rs.getString("id").equals(hbtForm.getCurid()))
			    		{
			    			ecMap.put("isgetdata", false);
			    			log.info("stop get data");
			    		}
			    		else
			    		{
			    			ecMap.put("isgetdata", true);
			    			log.info("start get data");
			    		}
					}
				}
				return ecMap;
			}
		});
	}
	
}

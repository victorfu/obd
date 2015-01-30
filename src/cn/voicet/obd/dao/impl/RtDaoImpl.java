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
import cn.voicet.obd.dao.RtDao;
import cn.voicet.obd.form.RtForm;

@Repository(RtDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class RtDaoImpl extends BaseDaoImpl implements RtDao {
	public static final Logger log = Logger.getLogger(RtDaoImpl.class);

	public List<Map<String, Object>> queryRtList(final DotSession ds, final RtForm rtForm) {
		log.info("sp:dev_Data_RT_Query(?,?,?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call dev_Data_RT_Query(?,?,?,?)}", new CallableStatementCallback() {
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

	public Map<String, Object> getMonitorDataMap(final DotSession ds, final RtForm rtForm) {
		log.info("sp:Car_Monitoring_RT(?,?)");
		return (Map<String, Object>)this.getJdbcTemplate().execute("{call Car_Monitoring_RT(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("cph", rtForm.getQchepai());
				cs.setString("rid", rtForm.getCurid());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> ecMap = null;
				if(rs!=null){
					while (rs.next()) {
						ecMap = new HashMap();
						ecMap.put("curid", rs.getString("id"));
			    		ecMap.put("rec",rs.getString("recvdate").substring(11,19));
			    		ecMap.put("vol",rs.getString("voltage"));
			    		ecMap.put("engs",rs.getString("enginespeed"));
			    		ecMap.put("run",rs.getString("runningspeed"));
			    		ecMap.put("sol",rs.getString("solarttermdooropen"));
			    		ecMap.put("engl",rs.getString("engineload"));
			    		ecMap.put("coo",rs.getString("coolanttermperature"));
			    		ecMap.put("cre",rs.getString("creeantoil"));
			    		ecMap.put("ave",rs.getString("averageoil"));
			    		ecMap.put("mil",rs.getString("mileage"));
			    		ecMap.put("tot",rs.getString("totalmileage"));
			    		ecMap.put("fue",rs.getString("fueloil"));
			    		ecMap.put("accu",rs.getString("accumulativeoil"));
			    		ecMap.put("err",rs.getString("errorcount"));
			    		ecMap.put("acce",rs.getString("acceleration"));
			    		ecMap.put("dec",rs.getString("deceleration"));
			    		//
			    		if(rs.getString("id").equals(rtForm.getCurid()))
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

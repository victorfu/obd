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
import cn.voicet.obd.dao.TipsDao;
import cn.voicet.obd.form.TipsForm;

@Repository(TipsDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class TipsDaoImpl extends BaseDaoImpl implements TipsDao {
	public static final Logger log = Logger.getLogger(TipsDaoImpl.class);

	public List<Map<String, Object>> queryTipsList(final DotSession ds, final TipsForm tipsForm) {
		log.info("sp:dev_Data_Alarm_Query(?,?,?,?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call dev_Data_Alarm_Query(?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setString("cph", ds.getCurChepai());
				cs.setInt("typs", tipsForm.getType());
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
}

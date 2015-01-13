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
				cs.setString("cph", rtForm.getChepai());
				cs.setString("sdt", ds.cursdttm);
				cs.setString("edt", ds.curedttm);
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

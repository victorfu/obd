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
import cn.voicet.obd.dao.GroupDao;
import cn.voicet.obd.form.GroupForm;

@Repository(GroupDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class GroupDaoImpl extends BaseDaoImpl implements GroupDao {
	public static final Logger log = Logger.getLogger(GroupDaoImpl.class);

	public List<Map<String, Object>> queryGroupList(final DotSession ds, final GroupForm groupForm) {
		log.info("flag:"+groupForm.getFlag());
		String sp = "dev_Data_group"+groupForm.getFlag()+"_Query(?,?,?,?)";
		log.info("sp:"+sp);
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call "+sp+"}", new CallableStatementCallback() {
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
}

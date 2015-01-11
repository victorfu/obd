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
import cn.voicet.obd.dao.ProxyDao;
import cn.voicet.obd.form.DeviceForm;
import cn.voicet.obd.form.ProxyForm;

@Repository(ProxyDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class ProxyDaoImpl extends BaseDaoImpl implements ProxyDao {
	public static final Logger log = Logger.getLogger(ProxyDaoImpl.class);

	public List<Map<String, Object>> queryProxyList(final DotSession ds, final ProxyForm proxyForm) {
		log.info("sp:web_Agent_Query(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_Agent_Query(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("uid", ds.roleID);
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

	public List<Map<String, Object>> queryDeviceList(final DotSession ds, final ProxyForm proxyForm) {
		log.info("sp:web_dev_agent_Query(?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_dev_agent_Query(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("uid", ds.roleID);
				cs.setInt("aid", proxyForm.getAid());
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

	public void selectDevice(final ProxyForm proxyForm) {
		String sp = "";
		if(proxyForm.getIscheck()==1)
		{
			sp = "web_dev_agent_share";
		}
		else
		{
			sp = "web_dev_agent_share_remove";
		}
		log.info("sp:"+sp+"(?,?)");
		this.getJdbcTemplate().execute("{call "+sp+"(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("aid", proxyForm.getAid());
				cs.setString("devno", proxyForm.getDevno());
				cs.execute();
				return null;
			}
		});
	}


	public void saveProxy(final ProxyForm proxyForm) {
		log.info("sp:web_Agent_Update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_Agent_Update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("aid", proxyForm.getAid());
				cs.setString("aname", proxyForm.getPname());
				cs.setInt("ienable", proxyForm.getIenable());
				cs.setString("addr", proxyForm.getAddr());
				cs.setString("tel", proxyForm.getTelnum());
				cs.setString("mobile", proxyForm.getMobile());
				cs.setString("qq", proxyForm.getQq());
				cs.setString("url", proxyForm.getUrl());
				cs.setInt("paid", proxyForm.getPaid());
				cs.setString("company", proxyForm.getCompany());
				cs.setInt("mode", proxyForm.getMode());
				cs.setInt("typ", proxyForm.getPtype());
				cs.setString("stdt", proxyForm.getSdt());
				cs.setString("etdt", proxyForm.getEdt());
				cs.setString("pic", proxyForm.getImg());
				cs.setString("mony", proxyForm.getMoney());
				cs.setString("mail", proxyForm.getEmail());
				cs.execute();
				return null;
			}
		});
	}
	
	public void deleteProxy(final ProxyForm proxyForm) {
		log.info("sp:web_Agent_Del(?)");
		this.getJdbcTemplate().execute("{call web_Agent_Del(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("aid", proxyForm.getAid());
				cs.execute();
				return null;
			}
		});
	}

}

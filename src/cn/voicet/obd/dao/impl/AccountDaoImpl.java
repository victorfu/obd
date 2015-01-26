package cn.voicet.obd.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.impl.BaseDaoImpl;
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.VTJime;
import cn.voicet.obd.dao.AccountDao;
import cn.voicet.obd.form.AccountForm;

@Repository(AccountDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class AccountDaoImpl extends BaseDaoImpl implements AccountDao {
	public static final Logger log = Logger.getLogger(AccountDaoImpl.class);

	public List<Map<String, Object>> queryAccountList(final DotSession ds, final AccountForm accountForm) {
		log.info("sp:web_user_Query(?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_user_Query(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setString("acc", accountForm.getQacc());
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

	public List<Map<String, Object>> queryCarList(final DotSession ds, final AccountForm accountForm) {
		log.info("sp:web_user_car_query_Available(?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_user_car_query_Available(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", accountForm.getUid());
				cs.setInt("puid", accountForm.getParentid());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				List<Object> list = new ArrayList<Object>();
				//取多结果集
				int rid = 0;
				while(cs.getUpdateCount()!=-1);
				while((rs=cs.getResultSet())!=null)  
                {  
                    while(rs.next())  
                    {  
                        if(rid==0)  
                        {  
                        	map = new HashMap<String, Object>();
	   						VTJime.putMapDataByColName(map, rs);
	   		        		list.add(map); 
                        }  
                        else if(rid==1)  
                        {  
                        	map = new HashMap<String, Object>();
   						 	VTJime.putMapDataByColName(map, rs);
   						 	map.put("flag", "1");
   						 	list.add(map); 
                        }
                    }  
                    cs.getMoreResults();  
                    rid++;  
                }
				return list;
			}
		});
	}

	public void bindCar(final AccountForm accountForm) {
		this.getJdbcTemplate().execute(new ConnectionCallback() {
			public Object doInConnection(Connection con) throws SQLException,
					DataAccessException {
				CallableStatement cs = null;
				//分配
				if(accountForm.getIsbind()==1)
				{
					cs = con.prepareCall("{call web_user_car_share(?,?)}");
				}
				else if(accountForm.getIsbind()==0)
				{
					cs = con.prepareCall("{call web_user_car_share_remove(?,?)}");
				}
				//取消分配
				else
				{
					System.out.println("isbind error");
				}
				cs.setInt("uid", accountForm.getUid());
				cs.setInt("cid", accountForm.getCid());
				cs.execute();
				return null;
			}
		});
		
		
		
	}

	public void addAccount(final DotSession ds, final AccountForm accountForm) {
		log.info("sp:web_user_create_account(?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_user_create_account(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", ds.userid);
				cs.setInt("lev", accountForm.getUlevel());
				cs.setString("subaccount", accountForm.getUacc());
				cs.setString("uname", accountForm.getUname());
				cs.execute();
				return null;
			}
		});
	}

	public void deleteAccount(final DotSession ds, final AccountForm accountForm) {
		log.info("sp:web_user_Del(?)");
		this.getJdbcTemplate().execute("{call web_user_Del(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", accountForm.getUid());
				cs.execute();
				return null;
			}
		});
		
	}

	public Map<String, Object> getAccountInfo(final AccountForm accountForm) {
		String sql = "select * from tb_user where uid="+accountForm.getUid();
		log.info("sql:"+sql);
		return (Map<String, Object>)this.getJdbcTemplate().execute(sql, new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				while(rs.next())
				{
					map = new HashMap<String, Object>();
					VTJime.putMapDataByColName(map, rs);
				}
				return map;
			}
		});
	}

	public void saveAccountInfo(final DotSession ds, final AccountForm accountForm) {
		log.info("sp:web_user_update(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_user_update(?,?,?,?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("uid", accountForm.getUid());
				cs.setInt("lev", accountForm.getUlevel());
				cs.setString("account", accountForm.getUacc());
				cs.setString("uname", accountForm.getUname());
				cs.setString("ct", accountForm.getIdcardtype());
				cs.setString("cn", accountForm.getIdcard());
				cs.setString("qq", accountForm.getQq());
				cs.setString("mail", accountForm.getEmail());
				cs.setString("pic", accountForm.getPhoto());
				cs.setString("addr", accountForm.getAddr());
				cs.setString("tel", accountForm.getTelnum());
				cs.setString("mobile", accountForm.getMobile());
				cs.setString("noteinfo", accountForm.getNoteinfo());
				cs.execute();
				return null;
			}
		});
	}
}

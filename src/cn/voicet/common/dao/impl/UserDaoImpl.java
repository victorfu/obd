package cn.voicet.common.dao.impl;

import java.sql.CallableStatement;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.UserDao;
import cn.voicet.common.form.UserForm;
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.VTJime;

@Repository(UserDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class UserDaoImpl extends BaseDaoImpl implements UserDao {

	private static Logger log = Logger.getLogger(UserDaoImpl.class);
	public Map<String, Object> userLogin(final UserForm userForm) {
		log.info("sp:web_user_login(?,?)");
		return (Map<String, Object>)this.getJdbcTemplate().execute("{call web_user_login(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
			throws SQLException, DataAccessException {
				DatabaseMetaData md = cs.getConnection().getMetaData();
				log.info("数据库名称(name):" + md.getDatabaseProductName());
				log.info("数据库主版本(marjor):" + md.getDatabaseMajorVersion());
				log.info("数据库次版本(minor):" + md.getDatabaseMinorVersion());
				log.info("数据库版本(version):" + md.getDatabaseProductVersion());
				cs.setString("account", userForm.getAccount());
				cs.setString("pwd", userForm.getPassword());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				if (rs != null) {
					while (rs.next()) {
						map = new HashMap<String, Object>();
						VTJime.putMapDataByColName(map, rs);
					}
				}
				return map;
			}
		});
	}

	public boolean updateUserPassword(final DotSession ds, final UserForm userForm) {
		log.info("sp:web_user_chg_pwd(?,?,?,?)");
		return (Boolean)this.getJdbcTemplate().execute("{call web_user_chg_pwd(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("uid", "1");
				cs.setString("pwd", userForm.getOldpwd());
				cs.setString("newpwd", userForm.getNewpwd());
				cs.registerOutParameter("retv", Types.VARCHAR);
				cs.execute();
				log.info("ret:"+cs.getString("retv"));
				if(cs.getString("retv").equalsIgnoreCase("ok"))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
		});
	}

	public String registerUser(final UserForm userForm) {
		log.info("sp:web_user_register(?,?,?,?,?,?)");
		return (String)this.getJdbcTemplate().execute("{call web_user_register(?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("parentid", "1");
				cs.setString("puid", "0");
				cs.setString("account", userForm.getAccount());
				cs.setString("pwd", userForm.getPassword());
				cs.setString("devno", userForm.getDevno());
				cs.registerOutParameter("retv", Types.VARCHAR);
				cs.execute();
				return cs.getString("retv");
			}
		});
	}

	public String ansyUserName(final UserForm userForm) {
		String sql = "select count(*) from tb_user where acc='"+userForm.getAccount()+"'";
		log.info("sql:"+sql);
		int c = this.getJdbcTemplate().queryForInt(sql);
		if(c==0)
		{
			return "0";
		}
		else
		{
			return "1";	
		}
	}
}

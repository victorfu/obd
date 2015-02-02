package cn.voicet.common.dao.impl;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.UserDao;
import cn.voicet.common.form.UserForm;
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.SecurityHelper;
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
				cs.setString("account", userForm.getAccount());
				String encpwd = SecurityHelper.DESEncrypt(userForm.getPassword(), "8a!2e4b4%1b6e2&ba5.-011b?720f-=+");
				log.info("encpwd:"+encpwd);
				cs.setString("pwd", encpwd);
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
				cs.setInt("uid", ds.userid);
				String encpwd = SecurityHelper.DESEncrypt(userForm.getOldpwd(), "8a!2e4b4%1b6e2&ba5.-011b?720f-=+");
				String encnewpwd = SecurityHelper.DESEncrypt(userForm.getNewpwd(), "8a!2e4b4%1b6e2&ba5.-011b?720f-=+");
				logger.info("encpwd:"+encpwd);
				logger.info("encnewpwd:"+encnewpwd);
				cs.setString("pwd", encpwd);
				cs.setString("newpwd", encnewpwd);
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
				cs.setString("puid", "0");
				cs.setString("account", userForm.getAccount());
				String encpwd = SecurityHelper.DESEncrypt(userForm.getPassword(), "8a!2e4b4%1b6e2&ba5.-011b?720f-=+");
				logger.info("encpwd:"+encpwd);
				cs.setString("pwd", encpwd);
				cs.setString("devno", userForm.getDevno());
				cs.setString("cph", userForm.getChepai());
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

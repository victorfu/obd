package cn.voicet.common.dao;

import java.util.Map;

import cn.voicet.common.form.UserForm;
import cn.voicet.common.util.DotSession;

public interface UserDao{
	public final static String SERVICE_NAME = "cn.voicet.common.dao.impl.UserDaoImpl";
	Map<String, Object> userLogin(UserForm userForm);
	boolean updateUserPassword(DotSession ds, UserForm userForm);
	String registerUser(UserForm userForm);
}

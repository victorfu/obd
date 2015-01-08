package cn.voicet.gc.dao;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.BlackForm;

public interface BlackDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.BlackDaoImpl";
	void queryBlackList(DotSession ds, BlackForm blackForm);
	void saveTelnum(BlackForm blackForm);
	void deleteTelnumByBid(BlackForm blackForm);
	void emptyBlack();
	void exportData(BlackForm blackForm, HttpServletResponse response);
	void batchImportData(File uploadExcel);
}

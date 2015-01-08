package cn.voicet.gc.dao;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.TaskForm;

public interface TaskDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.TaskDaoImpl";
	void queryTaskList(DotSession ds);
	void queryTelByTid(DotSession ds, TaskForm taskForm);
	void exportData(TaskForm taskForm, HttpServletResponse response);
	void batchImportData(File uploadExcel, int tid, int kind);
	String deleteTaskByTid(TaskForm taskForm);
	String saveTask(TaskForm taskForm);
	void emptyTaskTel(TaskForm taskForm);
	void deleteTaskTelByTtid(TaskForm taskForm);
	void recallTel(TaskForm taskForm);
	void saveTaskTel(TaskForm taskForm);
	int blackFilter(TaskForm taskForm);
	void setAcdByTid(TaskForm taskForm);
	void queryAcdSelectedByTid(DotSession ds, TaskForm taskForm);
}

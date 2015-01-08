package cn.voicet.gc.dao;

import javax.servlet.http.HttpServletResponse;

import cn.voicet.common.util.DotSession;
import cn.voicet.gc.form.AgentForm;

public interface AgentDao{
	public final static String SERVICE_NAME = "cn.voicet.gc.dao.impl.AgentDaoImpl";
	void queryAgentList(DotSession ds);
	void queryAgentAnalyList(DotSession ds);
	String saveAgent(AgentForm agentForm);
	void deleteAgentByAccount(AgentForm agentForm);
	void initAgentpwdByAgtid(AgentForm agentForm);
	void exportAgentAnalyData(DotSession ds, HttpServletResponse response);
	void queryAgentAnswerList(DotSession ds, AgentForm agentForm);
	void emptyAnswerByAgent(DotSession ds);
	void queryAgentOnlineList(DotSession ds, AgentForm agentForm);
	void queryAgentCalloutList(DotSession ds);
	void exportCalloutData(DotSession ds, HttpServletResponse response);
}

package cn.voicet.common.action;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BaseAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {

	private static Logger log = Logger.getLogger(BaseAction.class);
	protected HttpServletRequest request = null;
	protected HttpServletResponse response = null;
	protected ServletConfig config = null;
	
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	public void setServletConfig(ServletConfig config){
		this.config = config;
	}
	
	/**
	 * 获取当前页码
	 * @param request
	 * @return
	 */
	public int getCurrentPage(HttpServletRequest request) {
		int curPage = 1;
		String param = request.getParameter("curPage");
		if(null!=param && !param.trim().isEmpty())
		{
			try {
				curPage = Integer.parseInt(param);	
			} catch (RuntimeException e) {}
		}
		log.info("curPage:"+curPage);
		return curPage;
	}
	
	/**
	 * 截取url, 页面中的分页导航中需要使用它作为超链接的目标
	 * @param request
	 * @return
	 */
	public String getUrl(HttpServletRequest request) {
		String url = request.getRequestURI() + "?" + request.getQueryString();
		log.info("url before:"+url);
		/*
		 * 如果url中存在参数pc,则截取; 若不存在,则不用截取
		 */
		int index = url.lastIndexOf("&curPage=");
		if(index != -1){
			url = url.substring(0, index);
		}
		index = url.lastIndexOf("&curPage=");
		if(index != -1){
			url = url.substring(0, index);
		}
		log.info("url after:"+url);
		return url;
	}
}

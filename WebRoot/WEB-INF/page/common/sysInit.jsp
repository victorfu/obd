<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link type="text/css" rel="stylesheet" href="<c:url value='css/common.css'/>" />
	<link type="text/css" rel="stylesheet" href="<c:url value='css/layout.css?v=2'/>" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
</head>
<body style="background:#E0EEFB;">
<div id="dbCon">
	<h3 class="h3_title" style="margin-top:60px;">客户端配置</h3>
	<div class="sys_init_info">
        <div class="lab_ipt_item">
	    	<span class="lab120">连接服务器：</span>
	        <div class="ipt-box">
	        	<input type="text" id="ipx" name="ip" value="" placeholder="服务器IP" maxlength="15" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">端口：</span>
	        <div class="ipt-box">
	        	<input type="text" id="portx" name="port" value="" placeholder="端口号" maxlength="5" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">客户端账号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="accountx" name="port" value="" placeholder="客户端账号" maxlength="10" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">&nbsp;</span>
	        <div class="ipt-box">
	        	<input type="button" class="btn4" value="链接" onclick="connectNTSServerBtn('${sessionScope.vts.account }','${sessionScope.vts.password }')"/>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120"></span>
	        <div class="ipt-box">
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div style="width:380px; height:1px; border-bottom:1px dashed #808080;"></div>
	    
	    <div class="lab_ipt_item">
	    	<span class="lab120">绑定分机：</span>
	        <div class="ipt-box">
	        	<input type="text" id="subtelx" name="subtel" value="${subtel }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">&nbsp;</span>
	        <div class="ipt-box">
	        	<input type="button" class="btn4" value="绑定" onclick="bindSubTelBtn()"/>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120"></span>
	        <div class="ipt-box">
	            <span class="asterisk"></span>
	        </div>
	    </div>
    </div>
</div>	
<script type="text/javascript">
	$(function(){
		//获取链接服务器ip
		$("#ipx").val($("#OCXPlugin",window.parent.document)[0].GetServerIP());
		//获取端口号
		$("#portx").val($("#OCXPlugin",window.parent.document)[0].GetServerPort());
		//获取账号
		$("#accountx").val($("#OCXPlugin",window.parent.document)[0].GetClientAccount());
		//获取绑定分机
		$("#subtelx").val($("#OCXPlugin",window.parent.document)[0].GetBindTelnum());
	});
</script>
<script type="text/javascript" src="<c:url value='js/CM.sysinit.js?v=17'/>"></script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
</body>
</html>
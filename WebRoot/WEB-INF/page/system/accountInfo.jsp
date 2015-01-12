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
	<h3 class="h3_title" style="margin-top:20px;">修改资料</h3>
	<input type="hidden" id="uidx" name="uid" value="${uid }"/>
	<input type="hidden" id="aidx" name="aid" value="${aid }"/>
	<input type="hidden" id="ulevelx" name="ulevel" value="${ulevel }"/>
	<div class="sys_init_info">
        <div class="lab_ipt_item">
	    	<span class="lab120">账号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="uaccx" name="uacc" value="${accMap.acc }" maxlength="15" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">姓名：</span>
	        <div class="ipt-box">
	        	<input type="text" id="unamex" name="uname" value="${accMap.name }"  maxlength="5" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">证件类型：</span>
	        <div class="ipt-box">
	        	<s:select id="idcardtypex" name="idcardtype" list="#application.vta.GetList('card_type')" listKey="id" cssStyle="width:160px; height:28px;" headerKey="0" headerValue="全部" listValue="str" value="#request.accMap.ct"></s:select>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">证件号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="idcardx" name="idcard" value="${accMap.cn }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">QQ：</span>
	        <div class="ipt-box">
	        	<input type="text" id="qqx" name="qq" value="${accMap.qq }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">邮箱：</span>
	        <div class="ipt-box">
	        	<input type="text" id="emailx" name="email" value="${accMap.mail }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">照片：</span>
	        <div class="ipt-box">
	        	<input type="text" id="photox" name="photo" value="${accMap.pic }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">地址：</span>
	        <div class="ipt-box">
	        	<input type="text" id="addrx" name="addr" value="${accMap.addr }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">电话：</span>
	        <div class="ipt-box">
	        	<input type="text" id="telnumx" name="telnum" value="${accMap.tel }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">手机：</span>
	        <div class="ipt-box">
	        	<input type="text" id="mobilex" name="mobile" value="${accMap.mobile }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">备注：</span>
	        <div class="ipt-box">
	        	<input type="text" id="noteinfox" name="noteinfo" value="${accMap.noteinfo }" maxlength="100" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">&nbsp;</span>
	        <div class="ipt-box">
	        	<input type="button" class="btn4" value="保存" onclick="saveAccount()"/>
	        	&nbsp;&nbsp;&nbsp;&nbsp;
	        	<input type="button" class="btn4" value="返回" onclick="history.go(-1)"/>
	        </div>
	    </div>
    </div>
</div>
<script type="text/javascript" src="<c:url value='js/obd_account.js?v=1'/>"></script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
</body>
</html>
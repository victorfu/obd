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
	<input type="hidden" id="ulevelx" name="ulevel" value="${ulevel }"/>
	<div class="sys_init_info">
        <div class="lab_ipt_item">
	    	<span class="lab120">账号：</span>
	        <div class="ipt-box">
	        	<label>${accMap.acc }</label>
	        	<input type="hidden" id="uaccx" name="uacc" value="${accMap.acc }" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">姓名：</span>
	        <div class="ipt-box">
	        	<input type="text" id="unamex" name="uname" value="${accMap.name }"  maxlength="15" class="ipt_text_w150 inputDefault" />
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
	        	<input type="text" id="idcardx" name="idcard" value="${accMap.cn }" maxlength="20" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">QQ：</span>
	        <div class="ipt-box">
	        	<input type="text" id="qqx" name="qq" value="${accMap.qq }" maxlength="15" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">邮箱：</span>
	        <div class="ipt-box">
	        	<input type="text" id="emailx" name="email" value="${accMap.mail }" maxlength="32" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">地址：</span>
	        <div class="ipt-box">
	        	<input type="text" id="addrx" name="addr" value="${accMap.addr }" maxlength="150" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">电话：</span>
	        <div class="ipt-box">
	        	<input type="text" id="telnumx" name="telnum" value="${accMap.tel }" maxlength="20" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">手机：</span>
	        <div class="ipt-box">
	        	<input type="text" id="mobilex" name="mobile" value="${accMap.mobile }" maxlength="15" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">备注：</span>
	        <div class="ipt-box">
	        	<input type="text" id="noteinfox" name="noteinfo" value="${accMap.noteinfo }" maxlength="200" class="ipt_text_w150 inputDefault" />
	        </div>
	    </div>
		<div id="accErrMsg" style="text-indent:80px; color:#f00"></div>
		<div id="nameErrMsg" style="text-indent:80px; color:#f00"></div>
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
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='js/CM.html.js?v=1'/>"></script>
<script type="text/javascript">

//保存用户
function saveAccount()
{
	var uid = $("#uidx").val();
	var aid = $("#aidx").val();
	var ulevel = $("#ulevelx").val();
	var uacc = $("#uaccx").val();
	var uname = $("#unamex").val();
	uname = removeHTMLTag(uname);
	var idcard = $("#idcardx").val();
	idcard = removeHTMLTag(idcard);
	var idcardtype = $("#idcardtypex").val();

	var qq = $("#qqx").val();
	qq = removeHTMLTag(qq);
	var email = $("#emailx").val();
	email = removeHTMLTag(email);
	var addr = $("#addrx").val();
	addr = removeHTMLTag(addr);
	var telnum = $("#telnumx").val();
	telnum = removeHTMLTag(telnum);
	var mobile = $("#mobilex").val();
	mobile = removeHTMLTag(mobile);
	var noteinfo = $("#noteinfox").val();
	noteinfo = removeHTMLTag(noteinfo);
	//
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{uid:uid, aid:aid, ulevel:ulevel, uacc:uacc, uname:uname, idcard:idcard, idcardtype:idcardtype, qq:qq, email:email, photo:'', addr:addr, telnum:telnum, mobile:mobile, noteinfo:noteinfo},
		url:"saveAccount.action",
		success: function(data) {
			alert("保存成功");
		}
	});
}
</script>
</body>
</html>
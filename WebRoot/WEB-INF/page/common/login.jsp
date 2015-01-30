<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='js/cookie.js'/>"></script>
 	<script type="text/javascript" src="<c:url value='js/CM.login.js?v=2'/>"></script>
 	
 	<!-- layer 弹出插件 start -->
	<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
	<!-- layer 弹出插件 end -->
	
 	<script type="text/javascript">
	$(function(){
		//账号输入框获取焦点 
 		document.all.account.focus();
 		//记住密码 
		var account = Cookie.getCookie("account_obd");
		var password =  Cookie.getCookie("password_obd");
		if(account){
			$("#account").val(account);
			$("#password").val(password);
			$("#rememberPass").attr("checked", true); 
		}
		else
		{
			$("#account").val('');
			$("#password").val('');
			$("#rememberPass").attr("checked", false); 
		}
	});
 	
 	document.onkeydown = function(e) {   
		var theEvent = e || window.event;   
		var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
		if (code == 13) {   
    		login();
    		return false;   
		}   
		return true;
	}
 	</script>
 	<title>企事业公车管理系统</title>
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
</head>
<body>
<div class="login_wrap">
   	<div class="login_main">
       	<div class="login_main_up">
           	<div class="login_product"><s:property value="#application.vta.product"/></div>
            <div class="login_company"><strong><s:property value="#application.vta.customer"/></strong></div>
		</div>
		<div class="login_main_down">
           	<div class="login_content">
               	<table class="table_login" border="0" cellpadding="0" cellspacing="0">
					<tbody>
						<tr height="28px">
							<th class="login_label">账号&nbsp;</th>
							<td><input type="text" id="account" name="account"  autocomplete="off" value="" placeholder="输入账号" tabindex="1" class="ipt155 inputDefault"/></td>
						</tr>
						<tr height="28px">
							<th class="login_label">密码&nbsp;</th>
							<td><input type="password" id="password" name="password"  autocomplete="off" value="" placeholder="输入密码" tabindex="2" class="ipt155 inputDefault"/></td>
						</tr>
						<tr height="28px">
							<th class="login_label">验证码&nbsp;</th>
							<td align="left">
								<input type="text" id="vercode" name="vercode" placeholder="输入验证码" class="ipt70 inputDefault" maxlength="4"/>
								<img src="${pageContext.request.contextPath }/verCode" id="verImg" title="点击图片更换验证码" class="cursor_p" height="20" width="60"/>
							</td>
						</tr>
						<tr height="28px">
							<th></th>
							<td>
								<input type="checkbox" id="rememberPass" name="rememberPass" value="yes"/><label for="rememberPass">记住密码</label>
							</td>
						</tr>
						<tr height="24px">
							<th></th>
							<td>
								<input type="button" onclick="login()" value="登&nbsp;&nbsp;录" class="btn4"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" onclick="location.href='user-register.action'" value="注&nbsp;&nbsp;册" class="btn4"/>
							</td>
						</tr>
					</tbody>
				</table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
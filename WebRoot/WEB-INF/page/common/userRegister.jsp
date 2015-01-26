<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>企事业公车管理系统</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link type="text/css" href="<c:url value='css/common.css?v=1'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
</head>
<body>
<div id="container">
<a id="popHuifang" target="mainFrame"></a>
	<!-- header -->
  	<div id="header">
  		<div class="tit2"></div>
	  	<div style="width: 200px;height: 85px; float: right;">
	  		<div class="tit1"><s:property value="#application.vta.product"/></div>
	  		<div class="tit3"><s:property value="#application.vta.provider"/></div>
		</div>
    </div>
    <!-- nav -->
  	<div id="nav">
    	<div class="nav_left">
    		<div class="nav_left_wel">
        	<span></span>
    		<span></span>
    		<span></span>
    		</div>
    		<div id="navigate" class="nav_left_path">
    		</div>
        </div>
        <div class="nav_right">
        </div>
    </div>
    <!-- main -->
  	<div id="OSC_Screen">
	<div id="OSC_Content" class="CenterDiv">

<style>/* 登录注册等相关页面的样式 */

#OSC_Footer {border:0;}
#user_page {
	font-size:10pt;
	overflow:hidden;
	background:#E0EEFB;
	border:1px solid #ddd;
	padding:20px;
}
#user_page #form_user {float:left;width:650px;}
#user_page #form_user h2 {font-size:16pt;font-weight:normal;color:#333;border-bottom:2px solid #ddd;margin:0 50px 0 0;padding-bottom:10px;}

#OSChinaLoginTip {margin:40px 0 20px 0;color:#060;}
#OSChinaLoginTip ul {overflow:hidden;margin:15px 0 0 0;}
#OSChinaLoginTip ul li {float:left; width:100px;}
#OSChinaLoginTip ul li#openid_gmail img {margin-top:8px;}
#OSChinaLoginTip ul li#openid_yahoo img {margin-top:15px;}
#OSChinaLoginTip ul li#openid_msn img {}
#OSChinaLoginTip ul li#openid_github img {margin-top:8px;}
#OSChinaLoginTip ul li#openid_sina img {margin-top:8px;}

#user_page #login_tip {float:right;width:300px;font-size:10.5pt;color:#666;}
#user_page #login_tip h3 {margin:30px 0 10px 0;font-size:11pt;}
#user_page #login_tip ol {
	font-size:10pt;
	padding:10px 5px;
	list-style-type: decimal;
	list-style-position: inside;
}

#user_page form .th {font-size:10.5pt;text-align:right;padding:10px;}
#user_page form td {vertical-align:middle;}
#user_page form input.TEXT {font-size:16px;padding:3px;border:1px solid #ccc;}
#user_page form input.TEXT:focus {border:1px solid #40AA53;outline: none;}
#user_page form select {font-size:16px;padding:3px;}
#user_page form input.BUTTON {
	font-size:14px;
	padding:0 5px;
	height:30px;
}
#user_page form input.SUBMIT {font-weight:bold;}
</style>
<div id="user_page">
<form id="form_user" action="<c:url value='user-reg.action'/>" method="post" style="float:left; width:620px;">
    <h2>用户注册</h2>	
	<table cellspacing="0" cellpadding="0">
    	<tbody>
    	<tr>
    		<td class="th">账号：</td>		
    		<td><input type="text" name="account" id="f_name" value="${account }" maxlength="20" class="TEXT" style="width:150px;"/>
				<span id="name_msg">2～20个字符，支持英文、数字和“_”格式"</span>
			</td>
    	</tr>
    	<tr>
    		<td class="th">登录密码：</td>
    		<td><input type="password" name="password" id="f_pwd" value="${password }" class="TEXT" style="width:150px;"/>
				<span id="password_msg">至少6位,必须是字母或特殊符号和数字结合</span>
			</td>    		
    	</tr>
    	<tr>
    		<td class="th">密码确认：</td>		
    		<td><input type="password" id="f_pwd2" class="TEXT" style="width:150px;"/></td>
    	</tr>
		<tr id="tr_email">
    		<td class="th">设备：</td>
    		<td>
				<input type="text" name="devno" id="f_devno" value="${devno }" class="TEXT" style="width:150px;"/>
				<span id="email_tip"></span>
			</td>    			
    	</tr>
    	<tr class="buttons">
    		<td class="th"></td>		
			<td style="padding:20px 0;">
    		<input type="button" onclick="userReg()" value="注册新用户 " class="BUTTON SUBMIT"/></span>
			<br/>
<script type="text/javascript">

	$(function(){
		$("#f_name").bind("blur",checkName);
		$("#f_pwd").bind("blur",checkPassword);
		$("#f_pwd2").bind("blur",checkPassword2);
		$("#f_devno").bind("blur",checkDevno);
	});

	function checkName()
	{
		var name = $("#f_name").val().trim();
		var reg = /^[a-zA-Z][a-zA-Z0-9_]*$/;
		if(!name)
		{
			$("#error_msg")[0].innerHTML="账号必须填写！";
			return false;
		}
		else if(!name.match(reg))
		{
			$("#error_msg")[0].innerHTML="账号为英文字母开头，只含有英文字母、数字和下划线！";
			return false;
		}
		else if(name.length<2 || name.length>20)
		{
			$("#error_msg")[0].innerHTML="账号长度为2-20个字符！";
			return false;
		}
		else
		{
			$("#error_msg")[0].innerHTML="";
			return true;
		}
	}

	function checkPassword()
	{
		var pwd = $('#f_pwd').val();
		if(pwd.length<6)
		{
			$("#error_msg")[0].innerHTML="密码长度小于6位！";
			return false;
		}
		else if(!pwd.match(/[0-9]/)||!(pwd.match(/[a-zA-Z]/)||/\W/.test(pwd)))
		{
			$("#error_msg")[0].innerHTML="密码必须是字母或特殊符号和数字结合！";
			return false;
		}
		else
		{
			$("#error_msg")[0].innerHTML="";
			return true;
		}
	}

	function checkPassword2()
	{
		if($('#f_pwd').val().length == 0 || $('#f_pwd').val() != $('#f_pwd2').val())
		{
			$("#error_msg")[0].innerHTML="两次密码必须填写，且要一致！";
			return false;
		}
		else
		{
			$("#error_msg")[0].innerHTML="";
			return true;
		}
	}

	function checkDevno()
	{
		var devno = $("#f_devno").val().trim();
		if(!devno)
		{
			$("#error_msg")[0].innerHTML="设备必须填写！";
			return false;
		}
		else
		{
			$("#error_msg")[0].innerHTML="";
			return true;
		}
	}
	
	function userReg()
	{
		if(!checkName()) return false;
		if(!checkPassword()) return false;
		if(!checkPassword2()) return false;
		if(!checkDevno()) return false;
		//
		var name = $("#f_name").val().trim();
		var pwd = $('#f_pwd').val();
		var devno = $("#f_devno").val().trim();
		$.ajax({
	        type: "POST",
	        url: "user-reg.action",
	        data: {account:name, password:pwd, devno:devno},
	        success: function(result){
				if(result=="0")
				{
					alert("注册成功,立即登录!");
					location.href="index.action";
				}
				else if(result=="-1")
				{
					$("#error_msg")[0].innerHTML="账号已存在！";
				}
				else if(result=="-2")
				{
					$("#error_msg")[0].innerHTML="设备状态不可用！";
				}
				else if(result=="-3")
				{
					$("#error_msg")[0].innerHTML="设备不存在！";
				}
				else
				{
					alert("请求失败 ");
				}
		    },
	        error: function () {
	            //alert(RES.REQUESTWRONG);
	        }
	    });
	}
</script>
			</td>
    	</tr>
    	
    	<tr>
    		<td class="th"></td>		
			<td style="color:#f00"><div id="error_msg"></div></td>
    	</tr>
	</tbody></table>
</form>
<div id="login_tip">
	已有帐号？ <a href="<c:url value='index.action'/>">直接登录</a>
	<h3>为什么要注册？</h3>
	<ol>
		<li>1.&nbsp;获取汽车最新状态</li>
		<li>2.&nbsp;查看车辆实时轨迹</li>
	</ol>
</div>
<div class="clear"></div>
</div>
<div class="clear"></div></div>

</div>
  	<!-- footer -->
  	<div id="footer">
        <p>
        <a href="#">设为首页</a>&nbsp;|&nbsp;
        <a href="#">收藏本站</a>&nbsp;|&nbsp;
        <a href="#">联系我们</a>&nbsp;|&nbsp;
        <a href="help.jsp" target="_blank">帮助中心</a>&nbsp;|&nbsp;
        <a href="#">常见问题</a>
        </p>
        <span>2014 VoiceT&nbsp;&nbsp;V141210&nbsp;&nbsp;[建议使用IE8以上版本或360兼容模式浏览器,&nbsp;显示器分辨率1280*1024]</span>
    </div>
    <!-- print window -->
	<div style="height:0px;">
	<iframe id="printFrame" name="printFrame" scrolling="no" width="1024" height="0" marginwidth="0" marginheight="0" frameborder="0" ></iframe>
	</div>
</div>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
</body>
</html>

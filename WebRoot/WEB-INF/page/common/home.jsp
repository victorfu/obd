<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>OBD-车载诊断系统</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css'/>" rel="stylesheet" />
	<link type="text/css" rel="stylesheet" href="<c:url value='css/dtree.css'/>" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='js/CM.dtree.js'/>"></script>
</head>
<body>
<div id="container">
<a id="popHuifang" target="mainFrame"></a>
	<!-- header -->
  	<div id="header">
  		<div class="tit1"><s:property value="#application.vta.product"/></div>
  		<div class="tit2"><s:property value="#application.vta.customer"/></div>
  		<div class="tit3"><s:property value="#application.vta.provider"/></div>
    </div>
    <!-- nav -->
    <!--  
  	<div id="nav">
    	<div class="nav_left">
    		<div class="nav_left_wel">
        	<span><a href="main.jsp" target="mainFrame" title="首页" style="color:#fff;">首页</a></span>
    		<span>欢迎：&nbsp;<s:property value="#session.vts.roleName"/></span>
    		<span><s:property value="#session.vts.username"/></span>
    		</div>
    		<div id="navigate" class="nav_left_path">
    		</div>
        </div>
        <div class="nav_right">
            <span><a class="menu_righta" href="javascript:showUpdatePwdDiv()" id="bt">修改密码</a></span>
            <span><a class="menu_righta" href="javascript:logout()">[&nbsp;注销&nbsp;]</a></span>
        </div>
    </div>
    -->
    <!-- main -->
  	<div id="main">
    	<div class="main_left">
    		<div class="dtree" style="height: 642px;">
    			<s:property value="#application.vta.getMenuInfoByRoleID(#session.vts.roleID, #session.vts.account)" escape="false"/>
    		</div>
    		<!-- 
            <ul class="menu">
                
            </ul>
            -->
        </div>
        <div class="main_right">
            <iframe id="mainFrame" name="mainFrame" src="<c:url value='${homePage }'/>" class="mainFrame" scrolling="no" marginwidth="1" marginheight="1" frameborder="0">
            </iframe>
        </div>
        <div class="clear"></div>
  	</div>
  	<!-- footer -->
  	<div id="footer">
        <p>
        <a href="#">设为首页</a>&nbsp;|&nbsp;
        <a href="#">收藏本站</a>&nbsp;|&nbsp;
        <a href="#">联系我们</a>&nbsp;|&nbsp;
        <a href="help.jsp" target="_blank">帮助中心</a>&nbsp;|&nbsp;
        <a href="#">常见问题</a>
        <!-- 记录js分页当前页码 start -->
        <input type="hidden" id="curTaskPage" value="1"/>
        <input type="hidden" id="curTelnumPage" value="1"/>
        <input type="hidden" id="curAcdPage" value="1"/>
        <input type="hidden" id="curAgentPage" value="1"/>
        <input type="hidden" id="curSubtelPage" value="1"/>
        <input type="hidden" id="curBlackPage" value="1"/>
        
        <%-- 客户资料导入及分配页面当前页 --%>
        <input type="hidden" id="curCusImportPage" value="1"/>
        <%-- 客户资料管理页面当前页 --%>
        <input type="hidden" id="curCusManagePage" value="1"/>
        <!-- 记录js分页当前页码 end -->
        </p>
        <span>2014 VoiceT&nbsp;&nbsp;V141210&nbsp;&nbsp;[建议使用IE8以上版本或360兼容模式浏览器,&nbsp;显示器分辨率1280*1024]</span>
    </div>
    <!-- print window -->
	<div style="height:0px;">
	<iframe id="printFrame" name="printFrame" scrolling="no" width="1024" height="0" marginwidth="0" marginheight="0" frameborder="0" ></iframe>
	</div>
</div>

<!--POP UPDATEPASS START-->
<div id="popDiv" style="display:none;"> 
	<form id="form1" action="<c:url value='/user-updatePwd.action'/>" method="post" onsubmit="return validatePwdinput(this)">
    <div class="lab_ipt_item">
    	<span class="lab120">账号：</span>
        <div class="ipt-box">
        	<label><s:property value="#session.vts.account"/></label>
        </div>
    </div>
    <div class="lab_ipt_item">
    	<span class="lab120">原密码：</span>
        <div class="ipt-box">
        	<input type="text" id="oldpwdx" name="oldpwd" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
    <div class="lab_ipt_item" id="ywtype">
    	<span class="lab120">新密码：</span>
        <div class="ipt-box">
        	<input type="password" id="newpwdx" name="newpwd" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
    <div class="lab_ipt_item" id="whnum">
    	<span class="lab120">确认密码：</span>
        <div class="ipt-box">
        	<input type="password" id="repwdx" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
	<div class="lab_ipt_item">
		<span class="lab120"></span>
		<div class="ipt-box"><input type="submit" class="btn4" value="确定"/></div>
		<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
	</div>	
	</form>
</div>
<!--POP UPDATEPASS END-->

<form id="form2" action="<c:url value='/user-logout.action'/>" method="post"></form>
<!--POP LAYER END-->
<script type="text/javascript" src="<c:url value='/js/CM.updatepwd.js?v=3'/>"></script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='/layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='/js/jquery.form-3.46.0.js'/>"></script>
<script type="text/javascript">
	//logout
	function logout()
	{
		layer.confirm("确定要注销吗？",function(){
			$("#form2").ajaxSubmit({ 
				success:function(data){ //提交成功的回调函数
					location.href="index.action";
		        }
			});
		    return false;
		});
	}
</script>
</body>
</html>

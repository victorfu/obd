<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title></title>
	<link type="text/css" href="<c:url value='css/common.css?v=2'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=2'/>" rel="stylesheet" />

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件 start -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js?v=1'/>"></script>
    <!-- 日期控件 end -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">账号管理</h3>
   	<form name="form1" action="<c:url value='/account-query.action'/>" method="post">
   	<input type="hidden" id="pageflag" name="pageflag" value=""/>
	<div class="queryDiv">
		<ul class="queryWrap_ul">
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li><input type="button" onclick="addAccount()" class="btn4" value="添&nbsp;&nbsp;加"/></li>
	        <li></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">账号</th>
                     <th width="6%">级别</th>
                     <th width="6%">密码</th>
                     <th width="6%">姓名</th>
                     <th width="6%">车辆数</th>
                     <th width="6%">邮箱</th>
                     <th width="10%">操作</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${accList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.acc }</td>
					<td>
						<c:if test="${ls.lev eq 1 }">系统管理员</c:if>
						<c:if test="${ls.lev eq 2 }">管理员</c:if>
						<c:if test="${ls.lev eq 3 }">代理商</c:if>
						<c:if test="${ls.lev eq 4 }">用户</c:if>
					</td>
					<td>${ls.pwd }</td>
					<td>${ls.name }</td>
					<td>${ls.carcount }</td>
					<td>${ls.mail }</td>
					<td>
						<a href="<c:url value='account-viewCar.action?uid=${ls.uid }&parentid=${ls.puid }'/>">查看车辆</a>&nbsp;&nbsp;
						<a href="<c:url value='account-info.action?uid=${ls.uid }&aid=${ls.aid }&ulevel=${ls.lev }'/>">修改</a>&nbsp;&nbsp;
						<a href="javascript:deleteAccount('${ls.uid }','${status.count }')">删除</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- jPage start -->
   	<div class="holder left"></div>
   	<div id="legend1" class="holder left"></div>
    <!-- Item oriented legend -->
    <div id="legend2" class="holder left"></div>
    <div class="left">
	    <input type="text" id="tzval" value="1" class="ipt20 inputDefault"/>
 		<button id="tiaozhuan" class="btn btn-primary">跳转</button>
	</div>
    <!-- jPage end -->
    
    <!--POP ADDDEV START-->
    <div id="popAddAccountDiv" style="display:none;"> 
		<form id="form2" name="form2" action="<c:url value='/account-addAccount.action'/>" method="post">
	        	<c:choose>
	        		<c:when test="${sessionScope.vts.roleID eq 1 }">
	        			<div class="lab_ipt_item">
		        			<span class="lab120">用户级别：</span>
		        			<div class="ipt-box">
		        			<s:select name="ulevel" list="#{2:'管理员',3:'代理商',4:'用户'}" listKey="key" listValue="value" cssStyle="width:160px; height:26px;"></s:select>
		        			 </div>
	   					</div>
	        		</c:when>
	        		<c:when test="${sessionScope.vts.roleID eq 2 }">
	        			<div class="lab_ipt_item">
	        				<span class="lab120">用户级别：</span>
	        				<div class="ipt-box">
			        			<s:select name="ulevel" list="#{3:'代理商',4:'用户'}" listKey="key" listValue="value" cssStyle="width:160px; height:26px;"></s:select>
			        		 </div>
	    				</div>
	    			</c:when>
	        	</c:choose>
	       
	    <div class="lab_ipt_item">
	    	<span class="lab120">账号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="uaccx" name="uacc" class="ipt_text_w150 inputDefault"  maxlength="15"/>
	            <span class=""></span>
	        </div>
	    </div>
	    <div id="accErrMsg" style="text-indent:80px; color:#f00"></div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">初始密码：</span>
	        <div class="ipt-box">
	        	<label>123456</label>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">用户姓名：</span>
	        <div class="ipt-box">
	        	<input type="text" id="unamex" name="uname" class="ipt_text_w150 inputDefault" maxlength="15"/>
	        </div>
	    </div>
	    <div id="nameErrMsg" style="text-indent:80px; color:#f00"></div>
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="addAccountBtn()"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
		</form>
	</div>
    <!--POP ADDDEV END-->
</div>
<script type="text/javascript">
//split page task
$(function(){
	var nowPage = parent.document.getElementById("curCusManagePage").value;
	var pflag = "${pageflag }";
	if(!pflag)
	{
		nowPage = 1;
	}
	$("div.holder").jPages({
		containerID : "movies",
        first : "首页",
        previous : "上一页",
        next : "下一页",
        last : "尾页",
        startPage : nowPage,
        perPage : 24,
        keyBrowse:true,
        delay : 0,
        callback : function( pages, items ){
			parent.document.getElementById("curCusManagePage").value = pages.current;
	        $("#legend1").html("&nbsp;&nbsp;当前第"+pages.current+"页 ,&nbsp;&nbsp;总共"+pages.count+"页,&nbsp;&nbsp;");
	        $("#legend2").html("当前显示第"+items.range.start+" - "+items.range.end+"条记录,&nbsp;&nbsp;总共"+items.count+"条记录&nbsp;&nbsp;");
	    }
	});
      /* when button is clicked */
	$("#tiaozhuan").click(function(){
  		/* get given page */
		var page = parseInt( $("#tzval").val() );

  		/* jump to that page */
  		$("div.holder").jPages( page );
	});
});
</script>

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript" src="<c:url value='js/obd_account.js?v=1'/>"></script>
</body>
</html>
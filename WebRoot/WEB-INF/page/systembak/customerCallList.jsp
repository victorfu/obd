<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=1'/>" rel="stylesheet" />
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
	<h3 class="h3_title">客户资料通话记录查询&nbsp;</h3>
   	<form name="form1" action="<c:url value='/callrecord-list.action'/>" method="post">
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
			<li><label>批次：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[0] }" maxlength="12"/></li>
			<li><label>车龄：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[0] }" maxlength="12"/></li>
	        <li><label>出险次数：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[0] }" maxlength="12"/></li>
	        <li><label>调查结果：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[1] }" maxlength="12"/></li>
		</ul>
		<ul class="queryWrap_ul">
			<li>
	        	<label>客户姓名：</label>
	        	<input type="text" id="waittimex" name="calltxt" class="ipt50 inputDefault" value="${calltxt[3] }"/>
	        </li>	       
	        <li>
	        	<label>手机：</label>
	        	<input type="text" id="waittimex" name="calltxt" class="ipt50 inputDefault" value="${calltxt[3] }"/>
	        </li>
	        <li>
	        	<label>所属话务员：</label>
	        	<input type="text" id="calltimex" name="calltxt" class="ipt50 inputDefault" value="${calltxt[4] }"/>
	        	<span class="asterisk"></span>
	        </li>
	        <li><input type="button" onclick="queryCall()" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li><input type="button" onclick="export()" class="btn4" value="导&nbsp;&nbsp;出"/></li>
		</ul>
	</div>
    </form>
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="4%">日期时间</th>
                     <th width="6%">联系号码</th>
                     <th width="4%">呼叫方向</th>
                     <th width="8%">接通情况</th>
                     <th width="6%">通话时长</th>
                     <th width="10%">备注</th>
                     <th width="12%">操作</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody">
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>13951776370</td>
					<td>
						<a href="">修改</a>&nbsp;&nbsp;
						<a href="">播放</a>&nbsp;&nbsp;
						<a href="">下载</a>&nbsp;&nbsp;
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- simple page start -->
   	<%@include file="/WEB-INF/page/common/simplePager.jsp"%>
    <!-- simple page end -->
</div>

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<script type="text/javascript" src="<c:url value='js/callrecord.js?v=16'/>"></script>
<script type="text/javascript" src="<c:url value='js/cts.js?v=2'/>"></script>
</body>
</html>
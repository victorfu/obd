<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=2'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件开始 -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js'/>"></script>
    <!-- 日期控件结束 -->
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
 	<!-- layer 弹出插件 start -->
	<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='layer/extend/layer.ext.js'/>"></script>
	<!-- layer 弹出插件 end -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">接听情况统计</h3>
   	<form action="<c:url value='/agentanaly-list.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul_w600 left">
			<li><label>开始日期：</label><input type="text" id="sdt" name="sdt" class="Wdate inputDefault" style="width:90px; height:18px;" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edt\')||\'2050-01-01\'}',skin:'whyGreen'})" value="<s:property value="#session.vts.cursdt"/>"/></li>
	        <li><label>结束日期：</label><input type="text" id="edt" name="edt" class="Wdate inputDefault" style="width:90px; height:18px;" onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdt\')}',maxDate:'%y-%M-%d',skin:'whyGreen'})" value="<s:property value="#session.vts.curedt"/>"/></li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li>
	        	<input type="button" class="btn4" onclick="location.href='${pageContext.request.contextPath }/agentanaly-export.action'" value="导出"/>
	        </li>
		</ul>
		<ul class="queryWrap_ul_w100 right">
	        <li></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head2">
                 <tr>
                     <th width="8%">分机号码</th>
                     <th width="8%">账号</th>
                     <th width="8%">姓名</th>
                     <th width="6%">请求<br/>次数</th>
                     <th width="6%">接听<br/>次数</th>
                     <th width="8%">总等待<br/>时长(秒)</th>
                     <th width="8%">平均等待<br/>时长(秒)</th>
                     <th width="8%">总通话<br/>时长(秒)</th>
                     <th width="8%">平均通话<br/>时长(秒)</th>
                     <th width="8%">接听超时<br/>次数</th>
                     <th width="8%">接听本方<br/>挂机次数</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<s:iterator id="agent" value="#session.vts.list">
				<tr align="center">
					<td>${agent.telnum }</td>
					<td>${agent.account }</td>
					<td>${agent.agtname }</td>
					<td>${agent.cn }</td>
					<td>${agent.ans }</td>
					<td>${agent.wait }</td>
					<td>${agent.wait_a }</td>
					<td>${agent.talk }</td>
					<td>${agent.talk_a }</td>
					<td>${agent.dl }</td>
					<td>${agent.el }</td>
				</tr>
				</s:iterator>
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
	
</div>
<script type="text/javascript">
	$(function(){
		$("div.holder").jPages({
			containerID : "movies",
	        first : "首页",
	        previous : "上一页",
	        next : "下一页",
	        last : "尾页",
	        startPage : 1,
	        perPage : 25,
	        keyBrowse:true,
	        delay : 0,
	        callback : function( pages, items ){
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

</body>
</html>
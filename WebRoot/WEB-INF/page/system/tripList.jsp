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
	<h3 class="h3_title">车辆行程查询</h3>
   	<form action="<c:url value='trip-query.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul">
	   		<li><label>车牌号码：</label><input type="text" name="qchepai" value="${sessionScope.vts.curChepai }" class="ipt100 inputDefault"/></li>
			<li><label>开始日期：</label><input type="text" id="sdt" name="sdt" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate ipt100 inputDefault" value="${sessionScope.vts.cursdt }" maxlength="20" style="height:18px"/></li>
	        <li><label>结束日期：</label><input type="text" id="edt" name="edt" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" class="Wdate ipt100 inputDefault" value="${sessionScope.vts.curedt }" maxlength="20" style="height:18px"/></li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="8%">行程编号</th>
                     <th width="8%">车牌号码</th>
                     <th width="12%">开始时间</th>
                     <th width="12%">结束时间</th>
                     <th width="6%">电瓶电压</th>
                     <th width="8%">热车时长</th>
                     <th width="8%">操作</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<c:forEach items="${tripList }" var="ls">
				<tr align="center">
					<td>${ls.tid }</td>
					<td>${ls.cph }</td>
					<td>${fn:substring(ls.sdt,0,19) }</td>
					<td>${fn:substring(ls.edt,0,19) }</td>
					<td>${ls.v1 }</td>
					<td>${ls.hct }</td>
					<td>
						<a href="<c:url value='trip-viewmap.action?cid=${ls.cid }&sdt=${fn:substring(ls.sdt,0,10) }&edt=${fn:substring(ls.edt,0,10) }'/>">查看</a>
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
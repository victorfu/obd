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
    <!-- 日期控件开始 -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js'/>"></script>
    <!-- 日期控件结束 -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">专业数据1</h3>
   	<form name="form1" action="<c:url value='group-query.action?flag=1'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul">
			<li><label>车牌号：</label><input type="text" name="qchepai" class="ipt100 inputDefault" value="${sessionScope.vts.curChepai }" maxlength="20"/></li>
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
                     <th width="4%">编号</th>
                     <th width="8%">车牌号码</th>
                     <th width="12%">接收时间</th>
                     <th width="8%">短期燃油校正</th>
                     <th width="8%">长期燃油校正</th>
                     <th width="8%">燃油压力</th>
                     <th width="8%">点火提前量</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${groupList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.id }</td>
					<td>${ls.cph }</td>
					<td>${ls.recvdate }</td>
					<td>${ls.shortfuel }</td>
					<td>${ls.longfuel }</td>
					<td>${ls.fuelpressure }</td>
					<td>${ls.lgnitionadvance }</td>
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
//split page task
$(function(){
	$("div.holder").jPages({
		containerID : "movies",
        first : "首页",
        previous : "上一页",
        next : "下一页",
        last : "尾页",
        startPage : 1,
        perPage : 24,
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

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript" src="<c:url value='js/obd_device.js?v=2'/>"></script>
</body>
</html>
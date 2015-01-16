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
	<h3 class="h3_title">实时数据查询</h3>
   	<form name="form1" action="<c:url value='rt-query.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul">
			<li><label>车牌号：</label><input type="text" name="chepai" class="ipt100 inputDefault" value="${chepai }" maxlength="20"/></li>
	        <li><label>开始日期：</label><input type="text" id="sdttm" name="sdttm" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt140 inputDefault" value="${sessionScope.vts.cursdttm }" maxlength="20" style="height:18px"/></li>
	        <li><label>结束日期：</label><input type="text" id="edttm" name="edttm" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt140 inputDefault" value="${sessionScope.vts.curedttm }" maxlength="20" style="height:18px"/></li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head2">
                 <tr>
                     <th width="6%">车牌号码</th>
                     <th width="6%">接收时间</th>
                     <th width="4%">电瓶<br/>电压</th>
                     <th width="4%">发动机<br/>转速</th>
                     <th width="4%">行驶<br/>车速</th>
                     <th width="4%">节气门<br/>开度</th>
                     <th width="4%">发动机<br/>负荷</th>
                     <th width="4%">冷却液<br/>温度</th>
                     <th width="4%">瞬时<br/>油耗</th>
                     <th width="4%">本次行<br/>驶里程</th>
                     <th width="4%">总里程</th>
                     <th width="4%">本次耗<br/>油量</th>
                     <th width="4%">累计耗<br/>油量</th>
                     <th width="4%">故障码<br/>数量</th>
                     <th width="4%">本次<br/>急加速</th>
                     <th width="4%">本次<br/>急减速</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${rtList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.cph }</td>
					<td>${fn:substring(ls.rdt,11,19) }</td>
					<td>${ls.vt }</td>
					<td>${ls.ep }</td>
					<td>${ls.rs }</td>
					<td>${ls.sd }</td>
					<td>${ls.el }</td>
					<td>${ls.ct }</td>
					<td>${ls.co }</td>
					<td>${ls.ao }</td>
					<td>${ls.mg }</td>
					<td>${ls.tm }</td>
					<td>${ls.fo }</td>
					<td>${ls.ao }</td>
					<td>${ls.ec }</td>
					<td>${ls.at }</td>
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
<script type="text/javascript" src="<c:url value='js/obd_device.js?v=2'/>"></script>
</body>
</html>
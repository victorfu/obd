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
    <link type="text/css" href="<c:url value='datetimepicker/jquery.datetimepicker.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datetimepicker/jquery.datetimepicker.js?v=1'/>"></script>
    <!-- 日期控件 end -->
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
	<h3 class="h3_title">车辆提醒查询</h3>
   	<form name="form1" action="<c:url value='tips-query.action'/>" method="post">
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
			<li><label>车牌号：</label><input type="text" name="chepai" class="ipt100 inputDefault" value="${chepai }" maxlength="20"/></li>
			<li>
				<label>提醒类型：</label>
				<s:select id="typex" name="type" list="#application.vta.GetList('tips_type')" listKey="id" listValue="str" value="type" cssStyle="width:80px; height:22px;"></s:select>
			</li>
	        <li><label>开始日期：</label><input type="text" id="sdttm" name="sdttm" class="ipt120 inputDefault" value="${sessionScope.vts.cursdttm }" maxlength="8"/></li>
	        <li><label>结束日期：</label><input type="text" id="edttm" name="edttm" class="ipt120 inputDefault" value="${sessionScope.vts.curedttm }" maxlength="20"/></li>
	        <script>
	        	$("#sdttm").datetimepicker({lang:'ch',step:10,format:'Y-m-d H:i:s'});
	        	$("#edttm").datetimepicker({lang:'ch',step:10,format:'Y-m-d H:i:s'});
	        </script>
		</ul>
		<ul class="queryWrap_ul" style="margin-top:-4px;">
	        <li></li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
	</div>
    </form>
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="4%">编号</th>
                     <th width="8%">车牌号码</th>
                     <th width="12%">日期时间</th>
                     <th width="6%">提醒类型</th>
                     <th width="6%">定位类型</th>
                     <th width="12%">经度</th>
                     <th width="12%">纬度</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${tipList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.lid }</td>
					<td>${ls.cid }</td>
					<td>${fn:substring(ls.dt,0,19) }</td>
					<td>
						<c:if test="${ls.dm eq 2 }">启动</c:if>
						<c:if test="${ls.dm eq 3 }">熄火</c:if>
						<c:if test="${ls.dm eq 4 }">休眠</c:if>
						<c:if test="${ls.dm eq 5 }">设备掉电</c:if>
						<c:if test="${ls.dm eq 6 }">协议不支持或通讯失败</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${ls.lx eq 1 }">GPS</c:when>
							<c:when test="${ls.lx eq 2 }">LBS</c:when>
							<c:otherwise>其它</c:otherwise>
						</c:choose>
					</td>
					<td>${ls.jd }</td>
					<td>${ls.wd }</td>
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
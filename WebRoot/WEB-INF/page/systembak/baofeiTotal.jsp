<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<h3 class="h3_title">保费汇总统计&nbsp;
		[<c:if test="${baomode eq 0 }">月汇总</c:if>
		<c:if test="${baomode eq 1 }">话务员汇总</c:if>
		<c:if test="${baomode eq 2 }">话务员月汇总</c:if>]
	</h3>
   	<form action="<c:url value='customer-baofeianaly.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul left">
			<li>
				<label>模式：</label>
	        	<s:select name="baomode" list="#application.vta.GetList('baodantotal')" onchange="changeBaomode(this)" listKey="id" listValue="str" value="baomode" cssStyle="width:100px; height:20px;"></s:select>
	        </li>
	        <li><label>起始日期：</label><input type="text" id="sdt" name="sdt" class="Wdate inputDefault" style="width:90px; height:18px;" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edt\')||\'2050-01-01\'}',skin:'whyGreen'})" value="<s:property value="#session.vts.cursdt"/>"/></li>
	        <li><label>终止日期：</label><input type="text" id="edt" name="edt" class="Wdate inputDefault" style="width:90px; height:18px;" onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdt\')}',maxDate:'%y-%M-%d',skin:'whyGreen'})" value="<s:property value="#session.vts.curedt"/>"/></li>
	        <li>
	        	<c:choose>
	        		<c:when test="${baomode eq 2 }">
	        			<c:set var="agtshow" value="display:block"></c:set>
	        		</c:when>
	        		<c:otherwise>
	        			<c:set var="agtshow" value="display:none"></c:set>
	        		</c:otherwise>
	        	</c:choose>
	        	<div id="hideagt" style="${agtshow }">
	        	<label>所属话务员：</label>
	        		<s:select list="alist" cssStyle="height:22px;" headerKey="" headerValue="--请选择话务员--" listKey="telnum" listValue="telagt" name="q_agtacc" value="q_agtacc"></s:select>
	        	</div>
	        </li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <script type="text/javascript">
	        	function changeBaomode(obj)
	        	{
		        	var hagt = document.getElementById("hideagt");
					if(obj.value==2)
					{
						hagt.style.display="block";
					}
					else
					{
						hagt.style.display="none";
					}
	        	}	
	        </script>
	        <li>
	        	<c:if test="${not empty(baoList) }">
	        	<input type="button" onclick="location.href='customer-exportBaodan.action?q_agtacc=${q_agtacc }&baomode=${baomode }'" class="btn4" value="导&nbsp;&nbsp;出"/>
	        	</c:if>
	        </li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<div>
			<label>保单数：${sessionScope.vts.map.bn }</label>&nbsp;&nbsp;&nbsp;&nbsp;
			<label>保费：<fmt:formatNumber value="${sessionScope.vts.map.baofei }" type="currency" pattern="0.00"/>元</label>&nbsp;&nbsp;&nbsp;&nbsp;
			<label>平均保费：<fmt:formatNumber value="${sessionScope.vts.map.baofei_a }" type="currency" pattern="0.00"/>元</label>
		</div>
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head2">
                 <tr>
                     <th width="10%">
                     	<c:choose>
                     		<c:when test="${baomode eq 1}">话务员</c:when>
                     		<c:otherwise>月份</c:otherwise>
                     	</c:choose>		
                     </th>
                     <th width="10%">保单数</th>
                     <th width="10%">保费金额(元)</th>
                     <th width="10%">单均额(元)</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<c:forEach items="${baoList }" var="ls">
				<tr align="center">
					<td>
						<c:choose>
                     		<c:when test="${baomode eq 1}">${ls.agtacc }</c:when>
                     		<c:otherwise>${ls.yearmon }</c:otherwise>
                     	</c:choose>	
					</td>
					<td>${ls.bn }</td>
					<td><fmt:formatNumber value="${ls.baofei }" type="currency" pattern="0.00"/></td>
					<td><fmt:formatNumber value="${ls.baofei_a }" type="currency" pattern="0.00"/></td>
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

</body>
</html>
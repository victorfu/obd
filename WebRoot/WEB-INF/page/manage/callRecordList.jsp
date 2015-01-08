<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=5'/>" rel="stylesheet" />

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
	<h3 class="h3_title">通话记录查询&nbsp;</h3>
   	<form name="form1" action="<c:url value='/callrecord-list.action'/>" method="post">
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
	   		<li>
			<label>平台名称：</label><s:select list="#session.vts.ctsList" onchange="changeServer(this,'')" listKey="ctsname" listValue="ctsname" value="#session.vts.curCTS" cssStyle="height:22px; margin:1px;"></s:select>
			</li>
			<li><label>开始日期：</label><input type="text" id="sdt" name="sdt" class="Wdate inputDefault" style="width:90px; height:20px;" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edt\')||\'2050-01-01\'}',skin:'whyGreen'})" value="<s:property value='#session.vts.cursdt'/>"/></li>
	        <li><label>结束日期：</label><input type="text" id="edt" name="edt" class="Wdate inputDefault" style="width:90px; height:20px;" onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdt\')}',maxDate:'%y-%M-%d',skin:'whyGreen'})" value="<s:property value='#session.vts.curedt'/>"/></li>
	        <li><label>主叫：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[0] }" maxlength="12"/></li>
	        <li><label>被叫：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[1] }" maxlength="12"/></li>
		</ul>
		<ul class="queryWrap_ul">
			<li>
	        	<label>呼叫方向：</label>
	        	<s:select name="calltxt" list="#{2:'不限',1:'呼入',0:'呼出'}" listKey="key" listValue="value" value="%{calltxt[2]}" cssClass="inputDefault"></s:select>
			</li>	       
	        <li>
	        	<label>等待时长：</label>
	        	<input type="text" id="waittimex" name="calltxt" title="如:>0" class="ipt50 inputDefault" value="${calltxt[3] }"/>
	        	<span class="asterisk"></span>
	        </li>
	        <li>
	        	<label>通话时长：</label>
	        	<input type="text" id="calltimex" name="calltxt" title="如:>0" class="ipt50 inputDefault" value="${calltxt[4] }"/>
	        	<span class="asterisk"></span>
	        </li>
	        <li><label>话务员号码：</label><input type="text" name="calltxt" class="ipt100 inputDefault" value="${calltxt[5] }"/></li>
	        <li><input type="button" onclick="queryCall()" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
	</div>
    </form>
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="4%">编号</th>
                     <th width="6%">平台名称</th>
                     <th width="9%">主叫号码</th>
                     <th width="9%">被叫号码</th>
                     <th width="6%">呼叫方向</th>
                     <th width="10%">振铃/摘机</th>
                     <th width="6%">应答</th>
                     <th width="6%">挂机</th>
                     <th width="4%">等待</th>
                     <th width="4%">通话</th>
                     <th width="6%">结束方式</th>
                     <th width="7%">话务员</th>
                     <th width="7%">操作</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<c:forEach items="${callList}" var="ls">
				<tr align="center">
					<td>${ls.csid }</td>
					<td>${ls.cts }</td>
					<td>${ls.ani }</td>
					<td>${ls.dnis }</td>
					<td>${ls.callio}</td>
					<td>${fn:substring(ls.callin,5,19) }</td>
					<td>${fn:substring(ls.answer,10,19) }</td>
					<td>${fn:substring(ls.onhook,10,19) }</td>
					<td>${ls.wait }</td>
					<td>${ls.talk }</td>
					<td>${ls.endcode }</td>
					<td>${ls.agent }</td>
					<td>
						<c:choose>
							<c:when test="${empty ls.recflag}">
								<label style="color:#808080;">播放&nbsp;&nbsp;</label>
								<label style="color:#808080;">下载</label>
							</c:when>
							<c:otherwise>
								<a href="javascript:play('<s:property value="#application.vta.getIpWithCTS(#session.vts.curCTS)"/>','${fn:substring(ls.recflag,26,fn:length(ls.recflag)) }','${fn:replace(fn:substring(ls.recflag,12,fn:length(ls.recflag)),'\\','/') }')">播放</a>&nbsp;&nbsp;
								<a href="${pageContext.request.contextPath }/callrecord-downloadNet.action?wavFile=${fn:replace(fn:substring(ls.recflag,12,fn:length(ls.recflag)),'\\','/') }">下载</a>
							</c:otherwise>
						</c:choose>
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
	        perPage : 22,
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
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<script type="text/javascript" src="<c:url value='js/callrecord.js?v=18'/>"></script>
<script type="text/javascript" src="<c:url value='js/cts.js?v=2'/>"></script>
</body>
</html>
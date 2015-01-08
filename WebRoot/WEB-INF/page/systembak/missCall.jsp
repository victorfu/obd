<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=1'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=3'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件开始 -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js'/>"></script>
    <!-- 日期控件结束 -->
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
 	<style type="text/css">
		a.losta:visited{color:#FF0000;}
 	</style>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">未接来电查看</h3>
	<div class="content_List615">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">编号</th>
                     <th width="10%">呼叫时间</th>
                     <th width="10%">来电号码</th>
                     <th width="10%">等待时长(秒)</th>
                     <th width="6%">备注</th>
                     <th width="10%">操作</th>
                 </tr>
             </thead>
             <tbody id="movies">
             	<c:forEach items="${mcList }" var="ls" varStatus="status">
				<tr align="center">
					<td>${ls.csid }</td>
					<td>${fn:substring(ls.callin,0,19) }</td>
					<td>${ls.ani }</td>
					<td>${ls.wait }</td>
					<td id="huflag_${status.count }">
						<c:choose>
							<c:when test="${ls.replyit eq 1 }">已呼</c:when>
							<c:otherwise>未呼</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a class="losta" href="javascript:callCustomer('${ls.ani }','${ls.csid }','${status.count }')">呼叫</a>&nbsp;&nbsp;
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
//split agent page
$(function(){
	var nowPage = parent.document.getElementById("curAgentPage").value;
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
        perPage : 28,
        keyBrowse:true,
        delay : 0,
        callback : function( pages, items ){
			parent.document.getElementById("curAgentPage").value = pages.current;
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
//bind click event
document.onkeydown = function(e) {   
	var theEvent = e || window.event;   
	var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
	if (code == 13) {   
		saveAgentBtn();
		return false;   
	}   
	return true;
}
</script>
<script type="text/javascript">
	//呼叫
	function callCustomer(mobile,cid,index)
	{
		var ocx = $("#OCXPlugin",window.parent.document)[0];
		var callingTel = $("#calling_num",window.parent.document)[0];
		var callid = ocx.GetCallID();
		ocx.doDialEx(mobile,"b,"+cid+","+callid);
		callingTel.innerHTML="正在呼叫："+mobile;
		//
		var datajson = {"cid":cid};
		var url = 'changeCallReply.action';
		$.ajax({
	        type: "POST",
	        url: url,
	        data: datajson,
	        success: function(){
				//标记已呼
				$("#huflag_"+index)[0].innerHTML="已呼";
	        },
	        error: function () {
	        	alert("设置失败");
	        }
	    });
		
	}
</script>
</body>
</html>
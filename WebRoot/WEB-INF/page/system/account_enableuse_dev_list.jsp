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
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<form name="form1" action="<c:url value='account-query.action'/>" method="post">
		<input type="hidden" name="pageflag" value="${pageflag }"/>
	</form>
	<h3 class="h3_title">分配设备
		<span><input type="button" value="返回" onclick="document.form1.submit();" class="btn4"/></span>
	</h3>
	<div class="content_List615">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">设备号</th>
                     <th width="8%">状态</th>
                     <th width="6%">厂家</th>
                     <th width="6%">型号</th>
                     <th width="12%">有效期</th>
                     <th width="12%">创建日期</th>
                     <th width="12%">分配</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${devList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.dsn }</td>
					<td>
						<c:if test="${ls.state eq 0 }">停用</c:if>
						<c:if test="${ls.state eq 10 }">未绑定</c:if>
						<c:if test="${ls.state eq 100 }">已绑定</c:if>
					</td>
					<td>${ls.cj }</td>
					<td>${ls.xh }</td>
					<td>${fn:substring(ls.ydt,0,19) }</td>
					<td>${fn:substring(ls.cdt,0,19) }</td>
					<td>
						<c:choose>
							<c:when test="${ls.flag eq 1}">
								<input type="checkbox" checked="checked" onclick="gouXuan(this,'${uid }','${ls.dsn }')"/>勾选	
							</c:when>
							<c:otherwise>
						<input type="checkbox" onclick="gouXuan(this,'${uid }','${ls.dsn }')"/>勾选	
							</c:otherwise>
						</c:choose>
						<script>
							function gouXuan(obj,uid,dsn)
							{
								var o;
								if(obj.checked==true)
								{
									o=1;
								}
								else
								{
									o=0;
								}
								var datajson = {"uid":uid,"devno":dsn,"ischeck":o};
								var url = 'account_selectDev.action';
								$.ajax({
							        type: "POST",
							        url: url,
							        data: datajson,
							        success: function(){},
							        error: function (){alert("操作失败");}
							    });
							}
						</script>
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
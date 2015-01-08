<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
	<link type="text/css" href="<c:url value='css/common.css?v=4'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=3'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='layer/skin/layer.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title1">客户资料导入&nbsp;<span class="down">点击<a href="${pageContext.request.contextPath }/excelTemplate/customer_importTemplate.xls">下载</a>模板文件</span></h3>
	<form id="form1" name="form1" action="<c:url value='/customer-importData.action'/>" method="post">
	
	</form>
	<div class="content_List615">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">批次号</th>
                     <th width="8%">创建日期</th>
                     <th width="4%">客户数</th>
                     <th width="4%">未分配数</th>
                     <th width="12%">备注信息</th>
                     <th width="16%" style="text-align:center">
                     	<input type="button" onclick="savePiNo('add','','')" value="创建批次" class="btn btn-primary"/>
                     </th>
                 </tr>
             </thead>
             <tbody id="movies" class="tab_tbody">
             	<c:forEach items="${pList }" var="ls">
				<tr align="center">
					<td>${ls.ids }</td>
					<td>${fn:substring(ls.cdt,0,19) }</td>
					<td>${ls.tn }</td>
					<td>${ls.un }</td>
					<td title="${ls.noteinfo }">
						<c:set var="notelen" value="${fn:length(ls.noteinfo) }"></c:set>
						<c:choose>
							<c:when test="${notelen gt 15}">${fn:substring(ls.noteinfo,0,15)}..</c:when>
							<c:otherwise>${ls.noteinfo }</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="javascript:savePiNo('edit','${ls.ids }','${ls.noteinfo }')">修改</a>&nbsp;&nbsp;
						<a href="javascript:showSelFile('${ls.ids }')">导入</a>&nbsp;&nbsp;
						<c:choose>
							<c:when test="${ls.un gt 0 }">
								<a href="javascript:alloc('${ls.ids }','${ls.un }','${fn:substring(ls.cdt,0,19) }','${ls.noteinfo }')">分配</a>&nbsp;&nbsp;	
							</c:when>
							<c:otherwise>
								<label style="color:#808080;">分配&nbsp;&nbsp;</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ls.tn gt 0 and ls.tn ne ls.un }">
								<a href="javascript:resetFenpei('${ls.ids }')">重置分配</a>&nbsp;&nbsp;	
							</c:when>
							<c:otherwise>
								<label style="color:#808080;">重置分配&nbsp;&nbsp;</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ls.tn gt 0 }">
								<a href="javascript:clearPino('${ls.ids }')">清空批次</a>&nbsp;&nbsp;	
							</c:when>
							<c:otherwise>
							<label style="color:#808080;">清空批次&nbsp;&nbsp;</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${ls.tn eq 0 }">
								<a href="javascript:deletePino('${ls.ids }')">删除</a>&nbsp;&nbsp;	
							</c:when>
							<c:otherwise>
							<label style="color:#808080;">删除&nbsp;&nbsp;</label>
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


<!--POP PLAYER START-->
<div id="popPiNoDiv" style="display:none;"> 
	<form id="form2" name="form2" action="<c:url value='/customer-savePiNo.action?curPage=${page.currentPage }'/>" method="post">
	    <div class="lab_ipt_item">
	    	<span class="lab120">批次号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="pinox" name="pino" class="ipt_text_w150 inputDefault" />
	        	<span id="pinolabel"></span>
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="h132">
	    	<span class="lab120">备注信息：</span>
	        <div class="h132 ipt-box">
	        	<textarea id="noteinfox" name="noteinfo" class="ipt_textarea_w300 inputDefault" style="font-size:12px;"></textarea>
	            <span></span>
	        </div>
	    </div>
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="savePiNoBtn()"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
	</form>
</div>
<!--POP PLAYER END-->

<!--POP LAYER START-->
<div id="popImportDataDiv" style="display:none;"> 
	<form id="form3" name="form3" 
		action="${pageContext.request.contextPath }/customer-importTelnum.action" 
		method="post" 
		enctype="multipart/form-data"
		onsubmit="return validateuploadInforFile(this)">
    <input type="hidden" id="imp_pino" name="pino" value=""/>
    <div class="lab_ipt_item">
    	<span class="lab120">选择文件：</span>
        <div class="ipt-box">
        	<input type="file" id="uploadExcel" name="uploadExcel"/>
        </div>
    </div>
	<div class="lab_ipt_item" id="importBtnDiv">
		<span class="lab120"></span>
		<div class="ipt-box"><input type="submit" class="btn4" value="确定"/></div>
		<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		<br/>
		<span class="asterisk"></span>
	</div>	
	</form>
</div>
<!--POP LAYER END-->

<%-- 清空批次 --%>
<form id="form4" name="form4" action="<c:url value='customer-clearPino.action'/>" method="post">
	<input type="hidden" name="pino" id="clear_pino"/>
</form>

<%-- 重置分配  --%>
<form id="form5" name="form5" action="<c:url value='customer-resetFenpei.action'/>" method="post">
	<input type="hidden" name="pino" id="reset_pino"/>
</form>

<%-- 分配  --%>
<form id="form6" name="form6" action="<c:url value='customer-alloc.action'/>" method="post">
	<input type="hidden" id="vpino" name="pino"/>
	<input type="hidden" id="vnoalloc" name="noalloc"/>
	<input type="hidden" id="vcdt" name="cdt"/>
	<input type="hidden" id="vnoteinfo" name="noteinfo"/>
</form>
<script type="text/javascript">
	function alloc(pino,noalloc,cdt,noteinfo)
	{
		$("#vpino").val(pino);
		$("#vnoalloc").val(noalloc);
		$("#vcdt").val(cdt);
		$("#vnoteinfo").val(noteinfo);
		document.form6.submit();
	}
</script>

<form id="form7" name="form7" action="<c:url value='customer-deletePici.action'/>" method="post">
	<input type="hidden" name="pino" id="delete_pino"/>
</form>

<script type="text/javascript">
//split page task
$(function(){
	var nowPage = parent.document.getElementById("curCusImportPage").value;
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
        startPage : 1,
        perPage : 28,
        keyBrowse:true,
        delay : 0,
        callback : function( pages, items ){
			parent.document.getElementById("curCusImportPage").value = pages.current;
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
document.onkeydown = function(e) {   
	var theEvent = e || window.event;   
	var code = theEvent.keyCode || theEvent.which || theEvent.charCode; 
	if (code == 13) {   
		savePiNoBtn();
		return false;   
	}   
	return true;
}
</script>

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='js/customer.js?v=18'/>"></script>

</body>
</html>
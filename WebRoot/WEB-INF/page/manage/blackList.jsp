<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>扶贫观察点管理系统</title>
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css'/>" rel="stylesheet" />
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
 	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">系统黑名单维护</h3>
   	<form id="form1" name="form1" action="<c:url value='/black-list.action'/>" method="post">
   	<div class="queryDiv">
   		<ul class="queryWrap_ul_w400 left">
	        <li><label>电话号码：</label><input type="text" class="ipt100 inputDefault" name="telnum" id="telnum" value="<s:property value="telnum"/>"/></li>
	        <li><input type="submit" id="searchImg" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
		<ul class="queryWrap_ul_w400 right">
			<li><input type="button" class="btn4" onclick="emptyBlack()" value="清空"/></li>
	        <li><input type="button" class="btn4" onclick="saveBlackNumber('add','','','')" value="添加"/></li>
	        <li>
	        	<label><a style="color:#00f" href="${pageContext.request.contextPath }/excelTemplate/black_import.xls">下载</a>模板</label>
	        </li>
	        <li>
	        	<input type="button" class="btn4" onclick="showSelFile()" value="导入"/>
	        </li>
	        <li>
	        	<input type="button" class="btn4" onclick="exportBlackData()" value="导出"/>
	        </li>
		</ul>
   	</div>
   	
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="8%">记录编号</th>
                     <th width="10%">电话号码</th>
                     <th width="50%">备注信息</th>
                     <th width="20%">操作</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<s:iterator id="black" value="#session.vts.list">
				<tr align="center">
					<td><s:property value="#black.bid"/></td>
					<td><s:property value="#black.telnum"/></td>
					<td align="left" class="tabtd1">&nbsp;&nbsp;<s:property value="#black.noteinfo"/></td>
					<td>
						<a href="javascript:saveBlackNumber('edit','<s:property value="#black.bid"/>','<s:property value="#black.telnum"/>','<s:property value="#black.noteinfo"/>')">修改</a>&nbsp;&nbsp;
						<a href="javascript:deleteBlack('${black.bid }')">删除</a>
					</td>
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
    
	<!--POP LAYER START-->
	<div id="popDiv" style="display:none;"> 
		<form name="form2" action="<c:url value='/black-saveTelnum.action'/>" method="post">
	    <input type="hidden" name="pageflag" value="update"/>
	    <input type="hidden" id="bidx" name="bid"/>
	    <div class="lab_ipt_item">
	    	<span class="lab100">电话号码：</span>
	        <div class="ipt-box">
	        	<input type="text" id="telnumx" name="telnum" class="ipt_text_w150 inputDefault" />
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="h132">
	    	<span class="lab100">备注信息：</span>
	        <div class="h132 ipt-box">
	        	<textarea id="noteinfox" name="noteinfo" class="ipt_textarea_w300 inputDefault" style="font-size:12px;"></textarea>
	            <span></span>
	        </div>
	    </div>
		<div class="lab_ipt_item">
			<span class="lab100"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="submitSaveNumberBtn()"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
		</form>
	</div>
	<!--POP LAYER END-->
	
	<form id="form3" action="<c:url value='/black-emptyBlack.action'/>" method="post">
		<input type="hidden" name="pageflag" value="update"/>
	</form>
	
	<form id="form4" action="<c:url value='/black-deleteTelnum.action'/>" method="post">
		<input type="hidden" id="del_bid" name="bid"/>
	</form>
	
	<!--POP LAYER START-->
	<div id="popImportDiv" style="display:none;"> 
		<form id="form5" name="form5" 
			action="${pageContext.request.contextPath }/black-importBlacknum.action" 
			method="post" 
			enctype="multipart/form-data"
			onsubmit="return validateuploadInforFile(this)">
	    <div class="lab_ipt_item">
	    	<span class="lab120">您当前导入的文件：</span>
	        <div class="ipt-box">
	        	<input type="file" id="uploadExcel" name="uploadExcel"/>
	        </div>
	    </div>
	    
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="submit" class="btn4" value="确定"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
		</form>
	</div>
	<!--POP LAYER END-->
	
	<form name="form6" action="${pageContext.request.contextPath }/black-export.action" method="post">
		<input type="hidden" name="telnum" value="<s:property value="telnum"/>"/>
	</form>
	
</div>
<script type="text/javascript">
//jPage分页 
$(function(){
	var nowPage = parent.document.getElementById("curBlackPage").value;
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
        perPage : 26,
        keyBrowse:true,
        delay : 0,
        callback : function( pages, items ){
			parent.document.getElementById("curBlackPage").value = pages.current;
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
		submitSaveNumberBtn();
		return false;   
	}   
	return true;
}
</script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<script type="text/javascript" src="<c:url value='js/black.js?v=18'/>"></script>
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js'/>"></script>
</body>
</html>
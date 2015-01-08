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
	<h3 class="h3_title">子账号管理</h3>
   	<form name="form1" action="<c:url value='/account-query.action'/>" method="post">
   	<input type="hidden" id="pageflag" name="pageflag" value=""/>
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
			<li><label>设备号：</label><input type="text" name="q_pino" class="ipt100 inputDefault" value="${q_pino }" maxlength="20"/></li>
			<li><label>代理商：</label><input type="text" name="q_caryear" class="ipt60 inputDefault" value="${q_caryear }" maxlength="8"/></li>
	        <li><label>批次号：</label><input type="text" name="q_chuxcs" class="ipt60 inputDefault" value="${q_chuxcs }" maxlength="8"/></li>
	        <li><label>导入日期：</label><input type="text" name="q_chephm" class="ipt100 inputDefault" value="${q_chephm }" maxlength="20"/></li>
		</ul>
		<ul class="queryWrap_ul" style="margin-top:-4px;">
			<li>
	        	<label>车牌号码：</label>
	        	<input type="text" name="q_uname" class="ipt100 inputDefault" value="${q_uname }" maxlength="20"/>
	        </li>	       
	        <li>
	        	<label>用户姓名：</label>
	        	<input type="text" name="q_mobile" class="ipt100 inputDefault" value="${q_mobile }" maxlength="11"/>
	        </li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li><input type="button" onclick="saveAccount('0','','','','','','','','')" class="btn4" value="添&nbsp;&nbsp;加"/></li>
	        <li></li>
		</ul>
	</div>
    </form>
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">UID</th>
                     <th width="4%">AID</th>
                     <th width="8%">DSN</th>
                     <th width="4%">PUID</th>
                     <th width="6%">ACC</th>
                     <th width="12%">lev</th>
                     <th width="12%">Name</th>
                     <th width="12%">CT</th>
                     <th width="6%">CN</th>
                     <th width="8%">操作</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${accList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.uid }</td>
					<td>${ls.aid }</td>
					<td>${ls.dsn }</td>
					<td>${ls.puid }</td>
					<td>${ls.acc }</td>
					<td>${ls.lev }</td>
					<td>${ls.name }</td>
					<td>${ls.ct }</td>
					<td>${ls.cn }</td>
					<td>
						<a href="javascript:saveAccount('1','${ls.dsn }','${ls.aid }','${ls.vid }','${ls.state }','${ls.cj }','${ls.xh }','${fn:substring(ls.ydt,0,19) }','${ls.sbm }')">修改</a>&nbsp;&nbsp;
						<a href="javascript:deleteAccount('${ls.dsn }','${status.count }')">删除</a>&nbsp;&nbsp;
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
    
    <!--POP ADDDEV START-->
    <div id="popSaveDeviceDiv" style="display:none;"> 
		<form id="form2" name="form2" action="<c:url value='/device-saveDevice.action'/>" method="post">
	    <div class="lab_ipt_item">
	    	<span class="lab120">设备编号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="devnox" name="devno" value="0" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">代理商：</span>
	        <div class="ipt-box">
	        	<input type="text" id="proxyx" name="proxy" class="ipt_text_w150 inputDefault"  maxlength="15"/>
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">设备类型：</span>
	        <div class="ipt-box">
	        	<input type="text" id="typex" name="type" class="ipt_text_w150 inputDefault" maxlength="15"/>
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">设备状态：</span>
	        <div class="ipt-box">
	        	<input type="text" id="statex" name="state" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">厂家：</span>
	        <div class="ipt-box">
	        	<input type="text" id="changjx" name="changj" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">型号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="devxhx" name="devxh" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">有效期：</span>
	        <div class="ipt-box">
	        	<input type="text" id="valdtx" name="valdt" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">识别码：</span>
	        <div class="ipt-box">
	        	<input type="text" id="identix" name="identi" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="saveDeviceBtn()"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
		</form>
	</div>
    <!--POP ADDDEV END-->
    
    
	<!--POP LAYER START-->
	<div id="popImportDataDiv" style="display:none;"> 
		<form id="form3" name="form3" 
			action="${pageContext.request.contextPath }/device-importDevice.action" 
			method="post" 
			enctype="multipart/form-data"
			onsubmit="return validateuploadInforFile(this)">
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
    
    <!-- 分配客户资料给话务员 -->
    <form id="form2" action="<c:url value='/customer-setAgtAlloc.action'/>" method="post">
		<input type="hidden" id="cidx" name="cid"/>
	</form>
	
    <%-- 删除客户资料 --%>
    <form id="form3" action="<c:url value='/customer-deleteCustomerInfo.action'/>" method="post">
		<input type="hidden" id="del_cidx" name="cid"/>
	</form>
	
	<form id="form4" name="form4" action="<c:url value='customer-viewDetail.action'/>" method="post">
		<input type="hidden" id="vcid" name="cid"/>
		<input type="hidden" id="vq_pino" name="q_pino"/>
		<input type="hidden" id="vq_caryear" name="q_caryear"/>
		<input type="hidden" id="vq_chuxcs" name="q_chuxcs"/>
		<input type="hidden" id="vq_chephm" name="q_chephm"/>
		<input type="hidden" id="vq_uname" name="q_uname"/>
		<input type="hidden" id="vq_mobile" name="q_mobile"/>
		<input type="hidden" id="vq_agtacc" name="q_agtacc"/>
		<input type="hidden" id="vq_state" name="q_state"/>
		<input type="hidden" name="viewall" value="${viewall }"/>
	</form>
    
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
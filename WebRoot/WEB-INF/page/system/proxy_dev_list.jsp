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
	<h3 class="h3_title">分配设备
		<span><input type="button" value="返回" onclick="history.go(-1)" class="btn4"/></span>
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
							<c:when test="${aid eq ls.aid}">
								<input type="checkbox" checked="checked" onclick="gouXuan(this,'${aid }','${ls.dsn }')"/>勾选	
							</c:when>
							<c:otherwise>
								<input type="checkbox" onclick="gouXuan(this,'${aid }','${ls.dsn }')"/>勾选	
							</c:otherwise>
						</c:choose>
						<script>
							function gouXuan(obj,aid,dsn)
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
								var datajson = {"aid":aid,"devno":dsn,"ischeck":o};
								var url = 'proxy_selectDev.action';
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
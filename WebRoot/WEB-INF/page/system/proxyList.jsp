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
	<h3 class="h3_title">代理商管理</h3>
   	<form name="form1" action="<c:url value='/proxy-query.action'/>" method="post">
	<div class="queryDiv">
		<ul class="queryWrap_ul">
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
	        <li><input type="button" onclick="saveProxy('0','0','','','','','','','','','','','','','','','','','')" class="btn4" value="添&nbsp;&nbsp;加"/></li>
	        <li></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="4%">姓名</th>
                     <th width="8%">启用</th>
                     <th width="8%">地址</th>
                     <th width="6%">电话</th>
                     <th width="4%">模式</th>
                     <th width="4%">设备数</th>
                     <th width="12%">创建日期</th>
                     <th width="12%">操作</th>
                 </tr>
             </thead>
             <tbody class="tab_tbody" id="movies">
				<c:forEach items="${proxyList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.aname }</td>
					<td>${ls.ienable }</td>
					<td>${ls.addr }</td>
					<td>${ls.tel }</td>
					<td>${ls.mode }</td>
					<td>${ls.devcount }</td>
					<td>${fn:substring(ls.crdt,0,19) }</td>
					<td>
						<a href="<c:url value='proxy-finddev.action?aid=${ls.aid }'/>">分配设备</a>&nbsp;&nbsp;
						<a href="javascript:saveProxy('1','${ls.aid }','${ls.aname }','${ls.ienable }','${ls.addr }','${ls.tel }','${ls.mobile }','${ls.qq }','${ls.url }','${ls.paid }','${ls.company }','${ls.mode }','${ls.typ }','${fn:substring(ls.stdt,0,19) }','${fn:substring(ls.etdt,0,19) }','${ls.pic }','${ls.mony }','${ls.mail }')">修改</a>&nbsp;&nbsp;
						<a href="javascript:deleteProxy('${ls.aid }','${status.count }')">删除</a>
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
    <div id="popSaveProxyDiv" style="display:none;"> 
		<form id="form2" name="form2" action="<c:url value='proxy-saveProxy.action'/>" method="post">
	    <input type="hidden" id="aidx" name="aid" value="0"/>
	    <div class="lab_ipt_item">
	    	<span class="lab120">代理商姓名：</span>
	        <div class="ipt-box">
	        	<input type="text" id="pnamex" name="pname" value="0" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk">*</span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">启用标识：</span>
	        <div class="ipt-box">
	            <input type="checkbox" id="ienablechk" onclick="checkEnable(this)" style="margin-top:6px;"/>
	        	<input type="hidden" id="ienablex" name="ienable"/>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">地址：</span>
	        <div class="ipt-box">
	        	<input type="text" id="addrx" name="addr" class="ipt_text_w150 inputDefault" maxlength="15"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">电话：</span>
	        <div class="ipt-box">
	        	<input type="text" id="telnumx" name="telnum" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">手机：</span>
	        <div class="ipt-box">
	        	<input type="text" id="mobilex" name="mobile" class="ipt_text_w150 inputDefault"  maxlength="10"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">QQ：</span>
	        <div class="ipt-box">
	        	<input type="text" id="qqx" name="qq" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">网址：</span>
	        <div class="ipt-box">
	        	<input type="text" id="urlx" name="url" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">父代理号：</span>
	        <div class="ipt-box">
	        	<input type="text" id="paidx" name="paid" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">公司：</span>
	        <div class="ipt-box">
	        	<input type="text" id="companyx" name="company" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">模式：</span>
	        <div class="ipt-box">
	        	<s:select id="modex" name="mode" list="#{1:'模式一',2:'模式二'}" listKey="key" listValue="value" cssStyle="width:160px; height:26px;"></s:select>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">类型：</span>
	        <div class="ipt-box">
	        	<s:select id="ptypex" name="ptype" list="#{1:'类型一',2:'类型二'}" listKey="key" listValue="value" cssStyle="width:160px; height:26px;"></s:select>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">开始时间：</span>
	        <div class="ipt-box">
	        	<input type="text" id="sdtx" name="sdt" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">结束时间：</span>
	        <div class="ipt-box">
	        	<input type="text" id="edtx" name="edt" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">图片：</span>
	        <div class="ipt-box">
	        	<input type="text" id="imgx" name="img" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">金额：</span>
	        <div class="ipt-box">
	        	<input type="text" id="moneyx" name="money" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
	    <div class="lab_ipt_item">
	    	<span class="lab120">邮箱：</span>
	        <div class="ipt-box">
	        	<input type="text" id="emailx" name="email" class="ipt_text_w150 inputDefault"  maxlength="20"/>
	            <span class="asterisk"></span>
	        </div>
	    </div>
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="saveProxyBtn()"/></div>
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
<script type="text/javascript" src="<c:url value='js/obd_proxy.js?v=2'/>"></script>
</body>
</html>
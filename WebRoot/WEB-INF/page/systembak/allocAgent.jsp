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
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
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
	<h3 class="h3_title">客户资料分配</h3>
	<form id="form1" name="form1" action="customer-importData.action" method="post">
   		<input type="hidden" name="q_pino" value="${q_pino }"/>
   	</form>
	<div class="queryDiv_h80">
	   	<ul class="queryWrap_ul">
			<li><label>当前批次号：</label><label>${pino }</label></li>
			<li><label>当前未分配资料总数：</label><label>${noalloc }</label></li>
			<li><label>创建日期：</label><label>${cdt }</label></li>
			<li><label>备注信息：</label><label>${noteinfo }</label></li>
		</ul>
		<form id="form2" name="form2" action="<c:url value='customer-allocAgent.action'/>">
		<input type="hidden" name="pino" id="pinox" value="${pino }"/>
		<ul class="queryWrap_ul">
			<li>
				<label>本次分配数：</label><input type="text" id="allocnumx" name="allocnum" class="ipt50"/>
				<input type="hidden" id="agtlistx" name="agentlist"/>
			</li>
			<li><div id="error_msg" class="error_msg1"></div></li>
			<li><input type="button" class="btn4" value="确定" onclick="allocAgent()"/></li>
			<li><input type="button" class="btn4" value="返回" onclick="history.go(-1)"/></li>
		</ul>
		</form>
	</div>
	
	<div class="content_List528">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
				<tr>
					<th width="2%" style="text-align:center">
						<input type="checkbox" id="allSel" onclick="allSelect()"/><label for="allSel">全选</label>&nbsp;&nbsp;
						<input type="checkbox" id="invertSel" onclick="invertSelect()"/><label for="invertSel">反选</label>
					</th>
                    <th width="6%">号码</th>
                    <th width="8%">姓名</th>
                 </tr>
             </thead>
             <tbody id="movies" class="tab_tbody">
             	<c:forEach items="${aList }" var="ls" varStatus="status">
				<tr>
					<td style="text-align:center"><input type="checkbox" name="chk_agt" value="${ls.telnum }" onclick="oneSelect()"/></td>
					<td>${ls.telnum }</td>
					<td>${ls.agtname }</td>
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

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript">

	function allSelect()
	{
		var agtlist="";
		var agts = $("input[name='chk_agt']");
		for(var i=0; i<agts.length; i++)
		{
			agts[i].checked="checked";
			agtlist = agtlist + agts[i].value + ","
		}
		$("#agtlistx").val(agtlist);
	}
	function invertSelect()
	{
		var agtlist="";
		var agts = $("input[name='chk_agt']");
		for(var i=0; i<agts.length; i++)
		{
			if(agts[i].checked==true)
			{
				agts[i].checked="";
			}
			else
			{
				agts[i].checked="checked";
				agtlist = agtlist + agts[i].value + ","
			}
		}
		$("#agtlistx").val(agtlist);
	}
	function oneSelect()
	{
		var agts = $("input[name='chk_agt']");
		var agtlist="";
		for(var i=0; i<agts.length; i++)
		{
			if(agts[i].checked==true)
			{
				agtlist += agts[i].value+",";
			}
		}
		$("#agtlistx").val(agtlist);
	}

	function checkAlloc()
	{
		var allocnum = $("#allocnumx").val();
		var agtlist = $("#agtlistx").val();
		var reg = /^[0-9]*[0-9][0-9]*$/;
		if(!allocnum)
		{
			$("#error_msg").css("display","block");
			$("#error_msg")[0].innerHTML="请输入分配数！";
			return false;
		}
		else if(!reg.exec(allocnum))
		{
			$("#error_msg").css("display","block");
			$("#error_msg")[0].innerHTML="请输入合理的分配数！";
			return false;
		}
		else if(allocnum > ${noalloc })
		{

			$("#error_msg").css("display","block");
			$("#error_msg")[0].innerHTML="不能大于未分配数！"
			return false;
		}
		else if(!agtlist)
		{
			$("#error_msg").css("display","block");
			$("#error_msg")[0].innerHTML="请勾选至少一个话务员！";
			return false;
		}
		else
		{
			$("#error_msg").css("display","none");
			$("#error_msg")[0].innerHTML="";
			return true;
		}
	}

	
	function allocAgent()
	{
		if(!checkAlloc()) return;
		
		var pino = $("#pinox").val(); 
		var allocnum = $("#allocnumx").val();
		var agentlist = $("#agtlistx").val(); 
		$.ajax({
			async: false,
			type: "POST",
			data: {pino:pino,allocnum:allocnum,agentlist:agentlist},
			url: "allocAgent.action",
			success: function() {
				alert("分配成功");
				$("#pageflag").val("update");
				document.form1.submit();
			}
		});
		/*
		$("#form2").ajaxSubmit({ 
			success:function(data){ //提交成功的回调函数
				alert("分配成功");
				$("#pageflag").val("update");
				//document.form1.submit();
	        }
		});
		return false;
		*/
	}
	
</script>
</body>
</html>
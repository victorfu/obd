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
	<link type="text/css" href="<c:url value='css/layout.css?v=1'/>" rel="stylesheet" />
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件开始 -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js'/>"></script>
    <!-- 日期控件结束 -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">用户车辆管理</h3>
   	<form name="form1" action="<c:url value='car-query.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul_w600 left">
	        <li><input type="button" class="btn4" value="返&nbsp;&nbsp;回" onclick="location.href='<c:url value="account-query.action"/>'"/></li>
	        <li>
	        </li>
		</ul>
		<ul class="queryWrap_ul_w100 right">
	        <li></li>
		</ul>
	</div>
    </form>
	<div class="content_List568">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead class="tab_head">
                 <tr>
                     <th width="6%">车辆编号</th>
                     <th width="8%">设备号</th>
                     <th width="4%">品牌</th>
                     <th width="4%">型号</th>
                     <th width="10%">购车日期</th>
                     <th width="6%">车牌号</th>
                     <th width="8%">发动机</th>
                     <th width="4%">颜色</th>
                     <th width="4%">总里程</th>
                     <th width="6%">行驶次数</th>
                     <th width="12%">操作</th>
                 </tr>
             </thead>
             <tbody id="movies">
               	<c:forEach items="${carList }" var="ls" varStatus="status">
				<tr id="rowIndex_${status.count }" align="center">
					<td>${ls.cid }</td>
					<td id="row_devno${ls.cid }">${ls.dsn }</td>
					<td>${ls.pp }</td>
					<td>${ls.xh }</td>
					<td>${fn:substring(ls.gcdt,0,11) }</td>
					<td>${ls.cph }</td>
					<td>${ls.fdjh }</td>
					<td>${ls.ys }</td>
					<td>${ls.zlc }</td>
					<td>${ls.xscs }</td>
					<td>
						<c:choose>
							<c:when test="${ls.flag eq 1 }">
								<a href="account-fenpei.action?uid=${uid }&cid=${ls.cid }&isbind=1&parentid=${parentid }">分配</a>	
							</c:when>
							<c:otherwise>
								<a href="account-fenpei.action?uid=${uid }&cid=${ls.cid }&isbind=0&parentid=${parentid }">取消</a>
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

<div id="popSaveCarDiv" style="display:none;"> 
<form id="form2" name="form2" action="<c:url value='car-saveCar.action'/>" method="post">
	<input type="hidden" id="cidx" name="cid" value="0"/>
  	<div class="lab_ipt_item">
  		<span class="lab120">品牌：</span>
      	<div class="ipt-box">
      		<input type="text" id="pinpaix" name="pinpai" class="ipt_text_w150 inputDefault" maxlength="15"/>
          	<span class="asterisk">*</span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">型号：</span>
      	<div class="ipt-box">
      		<input type="text" id="xinghaox" name="xinghao" class="ipt_text_w150 inputDefault"  maxlength="10"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">购车时间：</span>
      	<div class="ipt-box">
      		<input type="text" id="buydtx" name="buydt" onclick="WdatePicker({skin:'whyGreen'})" class="ipt_text_w150 inputDefault"  maxlength="10"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">车牌号：</span>
      	<div class="ipt-box">
      		<input type="text" id="chepaix" name="chepai" class="ipt_text_w150 inputDefault"  maxlength="20"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">车架：</span>
      	<div class="ipt-box">
      		<input type="text" id="chejiax" name="chejia" class="ipt_text_w150 inputDefault"  maxlength="20"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
	<div class="lab_ipt_item">
  		<span class="lab120">发动机编号：</span>
      	<div class="ipt-box">
      		<input type="text" id="fadongx" name="fadong" class="ipt_text_w150 inputDefault"  maxlength="20"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">颜色：</span>
      	<div class="ipt-box">
      		<input type="text" id="colorx" name="color" class="ipt_text_w150 inputDefault"  maxlength="20"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">提醒：</span>
      	<div class="ipt-box">
      		<input type="checkbox" id="istipchk" onclick="checkTip(this)" style="margin-top:6px;"/>
	        <input type="hidden" id="tipx" name="tip" value="0"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
  	<div class="lab_ipt_item">
  		<span class="lab120">警告：</span>
      	<div class="ipt-box">
      		<input type="checkbox" id="iswarnchk" onclick="checkWarn(this)" style="margin-top:6px;"/>
	        <input type="hidden" id="warnx" name="warn" value="0"/>
          	<span class="asterisk"></span>
      	</div>
  	</div>
	<div class="lab_ipt_item">
		<span class="lab120"></span>
		<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="saveCarBtn()"/></div>
		<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
	</div>	
</form>
</div>
<!--POP ADDDEV END-->

    

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='layer/extend/layer.ext.js'/>"></script>
<!-- layer 弹出插件 end -->
<script type="text/javascript" src="<c:url value='js/obd_car.js?v=3'/>"></script>
</body>
</html>
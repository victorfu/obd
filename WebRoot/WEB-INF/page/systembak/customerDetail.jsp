<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=7'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=6'/>" rel="stylesheet" />

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
 	<script type="text/javascript" src="<c:url value='js/jquery.idTabs.min.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title" style="margin-top:2px;">客户&nbsp;[${tpMap.uname }]&nbsp;的资料详情&nbsp;&nbsp;批次号&nbsp;[${tpMap.ids }]
		<span>
			<input type="button" class="btn btn-primary" value="返回" onclick="document.form1.submit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</span>
	</h3>
	<%-- 方便保存返回操作，回到客户资料管理页面 --%>
   	<form id="form1" name="form1" action="customer-query.action" method="post">
   		<input type="hidden" name="q_pino" value="${q_pino }"/>
   		<input type="hidden" name="q_caryear" value="${q_caryear }"/>
   		<input type="hidden" name="q_chuxcs" value="${q_chuxcs }"/>
   		<input type="hidden" name="q_chephm" value="${q_chephm }"/>
   		<input type="hidden" name="q_uname" value="${q_uname }"/>
   		<input type="hidden" name="q_mobile" value="${q_mobile }"/>
   		<input type="hidden" name="q_agtacc" value="${q_agtacc }"/>
   		<input type="hidden" name="q_state" value="${q_state }"/>
   		<input type="hidden" id="pageflag" name="pageflag"/>
		<input type="hidden" name="viewall" value="${viewall }"/>
   	</form>
   	<div id="usual1" class="usual"> 
	    <%-- tabs start --%>
	    <div class="itab">
		  	<ul> 
			    <li><a href="#tab1" class="selected">资料详情</a></li>
			    <li><a href="#tab2">保费保单</a></li> 
			    <li><a href="#tab3">通话记录</a></li> 
		  	</ul>
	    </div> 
    	<%-- tabs end --%>
    	<%-- tab1 start --%>
  		<div id="tab1" class="tabson" style="padding-left:20px;">
  			<form id="form2" name="form2" action="<c:url value='customer-saveCustomerInfo.action'/>" method="post">
  			<input type="hidden" name="cid" value="${cid }"/>
  			<!--  
  			<div class="formtitle"><span>批次信息</span></div>
  			-->
  			<div class="queryDiv" style="border:0">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>导入批次：</label><input type="text" id="pinox" name="pino" value="${tpMap.ids }" class="ipt100" maxlength="100"/></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li>
						客户资料状态：&nbsp;<s:select name="hfqk" list="#application.vta.GetList('customerstate')" onchange="changeCustomerState(this)" listKey="id" listValue="str" value="%{#request.tpMap.state}"></s:select>
						<input type="hidden" id="cstate" value="0"/>
						<script type="text/javascript">
							function changeCustomerState(obj)
							{
								$("#cstate").val(obj.value);
							}
							function setCusState(cid)
							{
								var state = $("#cstate").val();
								var datajson = {"cid":cid, "state":state};
								var url = 'setCustomerState.action';
								$.ajax({
							        type: "POST",
							        url: url,
							        data: datajson,
							        success: function(){
										alert("设置成功");
							        },
							        error: function () {
							        	alert("设置失败");
							        }
							    });
							}
						</script>
					</li>
					<li>
						<input type="button" class="btn4" value="保&nbsp;&nbsp;存" onclick="setCusState('${cid }')"/>
					</li>
				</ul>
			</div>
			<div id="error_msg" class="error_msg"></div>
			<c:if test="${sessionScope.vts.roleID eq 3 }">
			<div class="formtitle"><span>预约信息</span></div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>预约日期时间：</label><input type="text" id="yuydatex" name="yuydate" value="${fn:substring(tpMap.pdt,0,19) }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s'})" class="Wdate inputDefault" style="width:180px; height:20px"/></li>
			        <li>
			        	<!-- 
			        	<label>预约时间：</label><input type="text" id="yuytimex" name="yuytime" value="${fn:substring(tpMap.pdt,11,16) }" onclick="WdatePicker({dateFmt:'HH:mm',minDate:'%H:%m'})" class="Wdate inputDefault" style="width:90px; height:20px"/>
			        	 -->
			        </li>
			        <li><input type="button" class="btn4" value="确&nbsp;&nbsp;定" onclick="setYuyDateTime('${cid }','1')"/></li>
			        <li>
			        	<c:set var="yuyueriqi" value="${fn:substring(tpMap.pdt,0,10) }"></c:set>
			        	<c:if test="${fn:length(yuyueriqi) gt 0}">
			        	<input type="button" class="btn4" value="取&nbsp;&nbsp;消" onclick="cancelYuyDateTime('${cid }','0')"/>
			        	</c:if>
			        </li>
				</ul>
			</div>
			</c:if>
			<div class="formtitle"><span>车辆信息</span></div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>车龄：</label><input type="text" id="caryearx" name="caryear" value="${tpMap.byear }" class="ipt50" maxlength="4"/></li>
			        <li><label>出险次数：</label><input type="text" id="chuxcsx" name="chuxcs" value="${tpMap.ot }" class="ipt50" maxlength="3"/></li>
			        <li><label>初登日期：</label><input type="text" name="chudrq" value="${fn:substring(tpMap.odt,0,10) }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate inputDefault" style="width:90px; height:20px" maxlength="22"/></li>
			        <li><label>保险到期：</label><input type="text" name="baoxdq" value="${fn:substring(tpMap.edt,0,10) }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate inputDefault" style="width:90px; height:20px" maxlength="22"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>厂牌号码：</label><input type="text" name="changphm" value="${tpMap.pp }" class="ipt100" maxlength="30"/></li>
			        <li><label>车牌号码：</label><input type="text" name="chephm" value="${tpMap.cp }" class="ipt80" maxlength="20"/></li>
			        <li><label>车架号：</label><input type="text" name="chejh" value="${tpMap.cfid }" class="ipt100" maxlength="30"/></li>
			        <li><label>发动机编号：</label><input type="text" name="fadjbh" value="${tpMap.eid }" class="ipt100" maxlength="30"/></li>
				</ul>
			</div>
			<div class="formtitle"><span>客户信息</span></div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>客户姓名：</label><input type="text" name="uname" value="${tpMap.uname }" class="ipt100" maxlength="20"/></li>
			        <li><label>身份证号：</label><input type="text" id="idcardx" name="idcard" value="${tpMap.crid }" class="ipt155" maxlength="18"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>手机：</label><input type="text" id="mobilex" name="mobile" value="${tpMap.mobile }" maxlength="20" class="ipt100"/>&nbsp;<img src="images/call_phone.jpg" title="呼叫" alt="呼叫" onclick="callMember('m')"/></li>
			        <li><label>家庭电话：</label><input type="text" id="hometelx" name="hometel" value="${tpMap.home }" maxlength="20" class="ipt100"/>&nbsp;<img src="images/call_tel.jpg" title="呼叫" alt="呼叫" onclick="callMember('h')"/></li>
			        <li><label>办公电话：</label><input type="text" id="officetelx" name="officetel" value="${tpMap.office }" maxlength="20" class="ipt100"/>&nbsp;<img src="images/call_tel.jpg" title="呼叫" alt="呼叫" onclick="callMember('o')"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>派送地址：</label><input type="text" name="address" value="${tpMap.addr }"  maxlength="100" class="ipt500"/></li>
				</ul>
			</div>
			<div class="queryDiv_n" style="height:142px;">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label style="vertical-align:top;">备注信息：</label><textarea name="noteinfo" class="ipt_area_w300">${tpMap.noteinfo }</textarea></li>
				</ul>
			</div>
			<div class="queryDiv_h">
			   	<ul class="queryWrap_ul_w600 left">
			        <li style="padding-left:280px"><input type="button" onclick="saveCustomerBtn()" value="保&nbsp;&nbsp;存" class="btn4"/></li>
			        <li style="padding-left:100px"><input type="button" onclick="history.go(-1)" value="返&nbsp;&nbsp;回" class="btn4"/></li>
				</ul>
				<ul class="queryWrap_ul_w100 right">
			        <li></li>
				</ul>
			</div>
			
			
			</form>
  		</div>
  		<%-- tab1 end --%>
  		<%-- tab2 start --%>
  		<div id="tab2" class="tabson" style="padding-left:20px;">
  			<div class="formtitle"><span>保费保单信息</span></div>
  			<div style="padding-left:170px;">
  			<form id="bandanForm" action="<c:url value='customer-saveBaodan.action'/>" method="post">
  				<input type="hidden" name="cid" value="${cid }"/>
  				<div class="lab_ipt_item">
			    	<span class="lab120">保费(元)：</span>
			        <div class="ipt-box">
			        	<c:set var="xsd" value="${fn:indexOf(tpMap.baofei,'.') + 3 }"></c:set>
			        	<input type="text" id="baofeix" name="baofei" value="${fn:substring(tpMap.baofei,0,xsd) }" class="ipt_text_w150 inputDefault" />
			            <span class="asterisk"></span>
			        </div>
			    </div>
			    <div class="lab_ipt_item">
			    	<span class="lab120">保单号：</span>
			        <div class="ipt-box">
			        	<input type="text" id="baodanx" name="baodan" value="${tpMap.baodan }" class="ipt_text_w150 inputDefault" />
			            <span class="asterisk"></span>
			        </div>
			    </div>
			    <div class="lab_ipt_item">
			    	<span class="lab120">到期日期：</span>
			        <div class="ipt-box">
			        	<input type="text" id="baoendx" name="baoend" value="${tpMap.baoend }" class="Wdate inputDefault" style="width:90px; height:26px; line-height:26px"  onclick="WdatePicker({skin:'whyGreen'})" />
			            <span class="asterisk"></span>
			        </div>
			    </div>
			    <div class="lab_ipt_item">
					<span class="lab120"></span>
					<div class="ipt-box"><input type="button" onclick="saveBaodanBtn()" class="btn4" value="确定"/></div>
					<div class="ipt-box"></div>
				</div>	
  			</form>
  			</div>
  			<script type="text/javascript">
  				function saveBaodanBtn()
  				{
  					$("#bandanForm").ajaxSubmit({ 
  						success:function(data){ //提交成功的回调函数
  							alert("保存成功！");
  				        }  
  					}); 
  				    return false;	//not refresh page
  				}
  			</script>
  		</div>
  		<%-- tab2 end --%>
  		<%-- tab3 start --%>
  		<div id="tab3" class="tabson">
  			<table cellpadding="0" cellspacing="0" class="tab_border">
				<thead class="tab_head">
	                 <tr>
	                     <th width="8%">联系号码</th>
	                     <th width="10%">通话时间</th>
	                     <th width="6%">呼叫方向</th>
	                     <th width="6%">接通情况</th>
	                     <th width="4%">通话(秒)</th>
	                     <!--
	                     <th width="12%">通话小结</th>
	                     -->
	                     <th width="12%">操作</th>
	                 </tr>
	             </thead>
	             <tbody class="tab_tbody">
	             	<c:forEach items="${callRecordList }" var="ls" varStatus="status">
					<tr align="center">
						<td>${ls.ani }</td>
						<td>${fn:substring(ls.onhook,0,19) }</td>
						<td>${ls.callio }</td>
						<td>${ls.callret }</td>
						<td>${ls.talk }</td>
						<!--
						<td id="ctIndex_${status.count }" title="${ls.content }">
							<c:set var="ctlen" value="${fn:length(ls.content) }"></c:set>
							<c:choose>
								<c:when test="${ctlen gt 10}">${fn:substring(ls.content,0,10)}..</c:when>
								<c:otherwise>${ls.content }</c:otherwise>
							</c:choose>
						</td>
						-->
						<td>
							<input type="hidden" id="trIndex_${status.count }" value="${ls.tr }"/>
							<!--  
							<a href="javascript:showTalk('${ls.cid }','${ls.tdt }','${status.count }')">小结查看</a>&nbsp;&nbsp;
							-->
							<c:choose>
								<c:when test="${empty ls.recflag}">
									<label style="color:#808080;">播放&nbsp;&nbsp;</label>
									<label style="color:#808080;">下载</label>
								</c:when>
								<c:otherwise>
									<a href="javascript:play('<s:property value="#session.vts.getIpWithCTS(#session.vts.curCTS)"/>','${fn:substring(ls.recflag,26,fn:length(ls.recflag)) }','${fn:replace(fn:substring(ls.recflag,12,fn:length(ls.recflag)),'\\','/') }')">播放</a>&nbsp;&nbsp;
									<a href="${pageContext.request.contextPath }/callrecord-downloadNet.action?wavFile=${fn:replace(fn:substring(ls.recflag,12,fn:length(ls.recflag)),'\\','/') }">下载</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
  		</div>
  		<%-- tab2 end --%>
  	</div>
   	
   	<script type="text/javascript"> 
      $("#usual1 ul").idTabs(); 
    </script>
	
</div>

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript" src="<c:url value='js/cts.js?v=2'/>"></script>
<script type="text/javascript" src="<c:url value='js/customer_info.js?v=27'/>"></script>
<script type="text/javascript">
	var ocx = $("#OCXPlugin",window.parent.document)[0];
	var callingTel = $("#calling_num",window.parent.document)[0];
	var ing = "正在呼叫：";
	var cid="<s:property value='cid'/>";
	var callid = ocx.GetCallID();
	function callMember(tag)
	{
		//添加呼叫次数
		addCallTime(cid);
		//
		var m = $("#mobilex").val();
		var h = $("#hometelx").val();
		var o = $("#officetelx").val();
		//
		if(tag=="m")
		{
			if(!m)
			{
				$("#error_msg").css("display","block");
				$("#error_msg")[0].innerHTML="手机号不能为空！";
				return false;
			}
			else
			{
				if(!checkMobile()) return;
				//ocx.doDial(m);
				ocx.doDialEx(m,"b,"+cid+","+callid);
				callingTel.innerHTML=ing+m;
			}
		}
		else if(tag=="h")
		{
			if(!h)
			{
				$("#error_msg").css("display","block");
				$("#error_msg")[0].innerHTML="家庭电话不能为空！";
				return false;
			}
			else
			{
				if(!checkHometel()) return;
				//ocx.doDial(h);
				ocx.doDialEx(h,"b,"+cid+","+callid);
				callingTel.innerHTML=ing+h;
			}
		}
		else if(tag=="o")
		{
			if(!o)
			{
				$("#error_msg").css("display","block");
				$("#error_msg")[0].innerHTML="办公电话不能为空！";
				return false;
			}
			else
			{
				if(!checkOfficetel()) return;
				//ocx.doDial(o);
				ocx.doDialEx(o,"b,"+cid+","+callid);
				callingTel.innerHTML=ing+o;
			}
		}
	}
</script>

<!--POP PLAYER START-->
<div id="popTalkDiv" style="display:none;"> 
	<form id="form3" name="form3" action="<c:url value='/customer-saveTalk.action'/>" method="post">
	    <input type="hidden" id="talk_cid" name="cid" value="${cid }"/>
	    <input type="hidden" id="talk_time" name="talkdt" value=""/>
	    <input type="hidden" id="talk_count" name="talkcount" value=""/>
	    <div class="lab_ipt_item">
	    	<span class="lab120">通话结果：</span>
	        <div class="ipt-box">
	        	<input type="radio" id="tr1" name="talkresult" value="1"/><label for="tr1">成功</label>
	        	<input type="radio" id="tr2" name="talkresult" value="0"/><label for="tr2">失败</label>
	            <span class=""></span>
	        </div>
	    </div>
	    <div class="h132">
	    	<span class="lab120">通话小结：</span>
	        <div class="h132 ipt-box">
	        	<textarea id="talk_noteinfo" name="noteinfo" class="ipt_textarea_w300 inputDefault" style="font-size:12px;">
	        	</textarea>
	            <span></span>
	        </div>
	    </div>
		<div class="lab_ipt_item">
			<span class="lab120"></span>
			<div class="ipt-box"><input type="button" class="btn4" value="确定" onclick="saveTalkBtn()"/></div>
			<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
		</div>	
	</form>
</div>
<!--POP PLAYER END-->
<script type="text/javascript">
	function showTalk(cid,tdt,count)
	{
		var tr = $("#trIndex_"+count).val();
		var content = $("#ctIndex_"+count)[0].innerHTML;
		if(tr==1)
		{
			$("#tr1")[0].checked=true;
			$("#tr2")[0].checked=false;
		}
		else if(tr==0)
		{
			$("#tr1")[0].checked=false;
			$("#tr2")[0].checked=true;
		}
		else
		{
			alert("error:"+tr);
		}
		$("#talk_time").val(tdt);
		$("#talk_noteinfo").val(content);
		$("#talk_count").val(count);
		$.layer({
			type: 1,
	        title: '通话小结',
	        offset: [($(window).height() - 290)/2+'px', ''],
	        border : [5, 0.5, '#666'],
	        area: ['450px','280px'],
	        shadeClose: false,
			bgcolor: '#EEF1F8',
			page:{dom:'#popTalkDiv'}
		});
	}
	//保存通话小结
	function saveTalkBtn()
	{
		$("#form3").ajaxSubmit({ 
			success:function(data){ //提交成功的回调函数
				layer.closeAll();
				var d = eval( '(' + data + ')' );
				var cid=d.cid;
				var tr=d.tr;
				var ct=d.ct;
				var count = d.count;
				$("#trIndex_"+count).val(tr);
				$("#ctIndex_"+count)[0].innerHTML=ct;
				alert("保存成功！");
	        }  
		}); 
	    return false;	//not refresh page
	}
</script>
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<script type="text/javascript" src="<c:url value='js/CM.play.js?v=1'/>"></script>
</body>
</html>
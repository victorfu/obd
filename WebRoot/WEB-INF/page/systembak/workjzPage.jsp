<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=3'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">今日通话情况分析</h3>
	<div class="content_List615">
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead>
                 <tr>
                     <td width="10%">类别</td>
                     <td width="10%">呼叫次数</td>
                     <td width="10%">通话时长(秒)</td>
                     <td width="10%">平均通话时长(秒)</td>
                     <td width="10%">等待时长(秒)</td>
                     <td width="10%">平均等待时长(秒)</td>
                 </tr>
             </thead>
             <tbody>
				<tr align="center">
					<td>总体</td>
					<td>${c1Map.tn }</td>
					<td>${c1Map.tt }</td>
					<td>${c1Map.at }</td>
					<td>${c1Map.tw }</td>
					<td>${c1Map.atw }</td>
				</tr>
				<tr align="center">
					<td>呼入</td>
					<td>${c1Map.itn }</td>
					<td>${c1Map.itt }</td>
					<td>${c1Map.iat }</td>
					<td>${c1Map.iw }</td>
					<td>${c1Map.iaw }</td>
				</tr>
				<tr align="center">
					<td>外呼</td>
					<td>${c1Map.otn }</td>
					<td>${c1Map.ot }</td>
					<td>${c1Map.oat }</td>
					<td>${c1Map.ow }</td>
					<td>${c1Map.oaw }</td>
				</tr>
			</tbody>
		</table>
		<br/>
		<h3 class="h3_title">客户情况分析</h3>
		<table cellpadding="0" cellspacing="0" class="tab_border">
			<thead>
                 <tr>
                     <td rowspan="2" width="10%">客户总数</td>
                     <td colspan="3">其中</td>
                     <td colspan="2">当日</td>
                 </tr>
                 <tr align="center">
					<td width="10%">成功数</td>
					<td width="10%">失败数</td>
					<td width="10%">跟踪数</td>
					<td width="10%">成功数</td>
					<td width="10%">失败数</td>
				</tr>
             </thead>
             <tbody>
				<tr align="center">
					<td>${c2Map.tn }</td>
					<td>${c2Map.sn }</td>
					<td>${c2Map.fn }</td>
					<td>${c2Map.dn }</td>
					<td>${c2Map.tsn }</td>
					<td>${c2Map.tfn }</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>
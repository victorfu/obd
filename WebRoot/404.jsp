<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>企事业公车管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	 	<meta http-equiv="cache-control" content="no-cache"/>
	 	<meta http-equiv="expires" content="0"/>
		<link type="text/css" rel="stylesheet" href="<c:url value='css/common.css'/>"/>
		<link type="text/css" rel="stylesheet" href="<c:url value='css/layout.css?v=1'/>"/>
		<script src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
		<script language="javascript">
			$(function(){
			    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
				$(window).resize(function(){  
			    $('.error').css({'position':'absolute','left':($(window).width()-490)/2});
		    })  
		});  
		</script>
	</head>
	<body style="background:#edf6fa;">
	    <div class="error">
		    <h2>非常遗憾，您访问的页面不存在！</h2>
		    <p></p>
		    <div class="reindex">
		    	<a href="<c:url value='index.action'/>" target="_top" class="tologin" style="color:#FFFFFF; text-decoration:none;">返回登录</a>
		    </div>
	    </div>
	</body>
</html>
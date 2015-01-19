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
	<style type="text/css">
	#allmap {width: 100%;height: 100%; overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">车辆实时定位监测</h3>
	<div id="allmap"></div>
</div>
<script src="http://api.map.baidu.com/api?v=2.0&ak=8TWE7qd96upvIp2ifKktjcwf"></script>
<script type="text/javascript">
	//百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	var point = new BMap.Point(118.92787900, 32.05748900);
	map.centerAndZoom(point, 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	var marker = new BMap.Marker(point);
	map.addOverlay(marker);
	marker.addEventListener("click",getAttr);
	function getAttr()
	{
		var p = marker.getPosition();
		alert("当前车辆位置：");
	}

	// 编写自定义函数,创建标注
	function addMarker(point){
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);
	}
</script>
<script type="text/javascript">
	var interval;
	$(function(){
		var time= 6000;
	    function run(){
			interval=setInterval(fun,time);
	    }
	    function fun(){
	    	// 随机向地图添加25个标注
	    	var bounds = map.getBounds();
	    	var sw = bounds.getSouthWest();
	    	var ne = bounds.getNorthEast();
	    	var lngSpan = Math.abs(sw.lng - ne.lng);
	    	var latSpan = Math.abs(ne.lat - sw.lat);
	    	var point = new BMap.Point(sw.lng + lngSpan * (Math.random() * 0.7), ne.lat - latSpan * (Math.random() * 0.7));
			addMarker(point);
			//map.centerAndZoom(point, 11);
	    };
	    run();
	});		
</script>
</body>
</html>
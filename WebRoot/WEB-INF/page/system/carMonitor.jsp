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
	<h3 class="h3_title">车辆实时定位监测
		<span><input type="button" value="返回" onclick="history.go(-1)" class="btn4"/></span>
	</h3>
	<div id="allmap"></div>
</div>
<script src="http://api.map.baidu.com/api?v=2.0&ak=8TWE7qd96upvIp2ifKktjcwf"></script>
<script type="text/javascript">
	//百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	var point = new BMap.Point(118.822774,32.029016);
	map.centerAndZoom(point, 14);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	//添加标注，如起点
	var marker = new BMap.Marker(new BMap.Point(118.822774,32.029016));
	map.addOverlay(marker);
	marker.addEventListener("click",getAttr);
	function getAttr()
	{
		var p = marker.getPosition();
		alert("当前车辆位置：");
	}
	
	var pointA = new BMap.Point(118.822774,32.029016);  // 创建点坐标A--大渡口区
	var pointB = new BMap.Point(118.826079,32.067212);  // 创建点坐标B--江北区
	var pointC = new BMap.Point(118.80452,32.063417);  // 创建点坐标B--江北区
	var pointD = new BMap.Point(118.772612,32.079695);  // 创建点坐标B--江北区
	//
	var points = [];
	points.push(pointA);
	points.push(pointB);
	points.push(pointC);
	points.push(pointD);
	
	var polyline = new BMap.Polyline(points, {strokeColor:"red", strokeWeight:6, strokeOpacity:0.5});  //定义折线
	map.addOverlay(polyline);
	// 编写自定义函数,创建标注
	function addMarker(point){
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);

	}

	// 定义一个控件类,即function
	function ZoomControl(){
	  // 默认停靠位置和偏移量
	  this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
	  this.defaultOffset = new BMap.Size(10, 10);
	}

	// 通过JavaScript的prototype属性继承于BMap.Control
	ZoomControl.prototype = new BMap.Control();

	// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
	// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
	ZoomControl.prototype.initialize = function(map){
	  // 创建一个DOM元素
	  var div = document.createElement("div");
	  // 添加文字说明
	  div.appendChild(document.createTextNode("查看历史定位"));
	  // 设置样式
	  div.style.cursor = "pointer";
	  div.style.border = "1px solid gray";
	  div.style.backgroundColor = "white";
	  // 绑定事件,点击一次放大两级
	  div.onclick = function(e){
		//map.setZoom(map.getZoom() + 2);
		location.href="trip-query.action";
	  }
	  // 添加DOM元素到地图中
	  map.getContainer().appendChild(div);
	  // 将DOM元素返回
	  return div;
	}
	// 创建控件
	var myZoomCtrl = new ZoomControl();
	// 添加到地图当中
	map.addControl(myZoomCtrl);
	
	
</script>
<script type="text/javascript">
	/*
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
	*/
</script>
</body>
</html>
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
	var map = new BMap.Map("allmap");            
	var point = new BMap.Point(116.404,39.915);   
	map.centerAndZoom(point,15);                    
	map.enableScrollWheelZoom();                        
	
	map.addControl(new BMap.NavigationControl());  
	map.addControl(new BMap.ScaleControl());  
	map.addControl(new BMap.OverviewMapControl());
	 
	//会动的标注
	//var marker = new BMap.Marker(point);  // 创建标注
	//map.addOverlay(marker);              // 将标注添加到地图中
	//marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	
	//鼠标点击出现当前经纬度
	function showInfo(e){
	alert(e.point.lng + ", " + e.point.lat);
	}
	map.addEventListener("click", showInfo);
	//动态画线
	
	var pointx = [116.399,116.405,116.425];
	var pointy = [39.910,39.920,39.900];
	//
	drawline();

	var count = 0;   
	function drawline()
	{
		if(pointx.length>1)
		{
		  setTimeout(function(){
			  setData();
			  //
			  var pointline = new BMap.Polyline([
				  new BMap.Point(pointx[count],pointy[count]),
				  new BMap.Point(pointx[count+1],pointy[count+1])
			  ]);
			  count++;
				if(count<pointx.length-1)
				{
			      drawline();
				}
				map.addOverlay(pointline);
			}, 1000);
		}
	}

	function setData()
	{
		//ajax get data
		$.ajax({
			type : "post",
			async : false, //同步执行
			url : "get_car_monitor.action",
			data : {},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				console.log("lng:"+result.lng);
				console.log("lat:"+result.lat);
				pointx.push(result.lng);
				pointy.push(result.lat);
			}
		});
	}
</script>
</body>
</html>
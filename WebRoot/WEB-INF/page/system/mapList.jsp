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
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件开始 -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js'/>"></script>
    <!-- 日期控件结束 -->
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
 	<!-- layer 弹出插件 start -->
	<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='layer/extend/layer.ext.js'/>"></script>
	<!-- layer 弹出插件 end -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
	<style type="text/css">
		#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
		#mapdata{width:866px; height:180px; max-height:160px; overflow-y:auto; border:1px solid #1F6EB5;}
		.map_data_tab{text-align:center;border-collapse:collapse;border-spacing:0; width:100%; line-height:20px;}
		.map_data_tab,td{border: 1px solid #3B9FFF;}
		.ed{
		 background-color:#FF6;
		}
	</style>
	<script src="http://api.map.baidu.com/api?v=2.0&ak=8TWE7qd96upvIp2ifKktjcwf"></script>
	<!-- 检索信息窗口对象  require start -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<!-- 检索信息窗口对象  require end -->
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">车辆行程查询
	<span><input type="button" value="返回" onclick="history.go(-1)" class="btn4"/></span>
	</h3>
	<div class="content_List450" id="mapview">
		<input type="hidden" id="cidx" value="${cid }"/>
		<input type="hidden" id="sdtx" value="${sdttm }"/>
		<input type="hidden" id="edtx" value="${edttm }"/>
		<div id="allmap"></div>
	</div>
	<input id="follow" type="checkbox"/><span style="font-size:12px;">画面跟随</span>
	<input id="play" type="button" value="播放" onclick="play();" disabled="disabled" />
	<input id="pause" type="button" value="暂停" onclick="pause();" disabled="disabled" />
	<input id="reset" type="button" value="重置" onclick="reset()" disabled="disabled" />
	<div id="mapdata"></div>
</div>
<script type="text/javascript">
	var map = new BMap.Map("allmap");			// 百度地图API功能
	map.centerAndZoom(new BMap.Point(118.790646, 32.048033), 14);
	//map.centerAndZoom("南京市", 14);					// 设置地图显示的城市和地图级别
	map.enableScrollWheelZoom();					// 启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();						// 启用地图惯性拖拽，默认禁用
	map.addControl(new BMap.NavigationControl());	// 添加默认缩放平移控件
	map.addControl(new BMap.ScaleControl());		// 添加比例尺控件
	map.addControl(new BMap.MapTypeControl());		// 添加地图类型控件
	map.addControl(new BMap.OverviewMapControl());	// 添加缩略地图控件

	//添加点击地图监听事件，点击地图后显示当前经纬度
	map.addEventListener("click", showInfo);
	//获取经纬度
	function showInfo(e)
	{
		//alert(e.point.lng + ", " + e.point.lat);
	}
	// 创建地理编码实例
	var geoc = new BMap.Geocoder();  

	//
	var car;   //汽车图标
	var label; //信息标签
	var centerPoint;
	
	var timer;     //定时器
	var index = 0; //记录播放到第几个point
	var followChk, playBtn, pauseBtn, resetBtn; //几个控制按钮
	followChk = document.getElementById("follow");
	playBtn = document.getElementById("play");
	pauseBtn = document.getElementById("pause");
	resetBtn = document.getElementById("reset");

	var mypoints;
	//
	
	$(function(){
		search();
	});

	function search()
	{
		var c = $("#cidx").val();
		var s = $("#sdtx").val();
		var e = $("#edtx").val();
		$.ajax({
			url : 'getmapdata.action',
			data:{cid:c,sdttm:s,edttm:e},
			type : "post",
			cache : false,
			success : function(data) {
				var result = eval('(' + data + ')');
				/*
				if(result.length==0)
				{
					alert('没有坐标位置数据');
				}
				*/
				map.clearOverlays();									// 清除标注信息
			    var points = [];										// 添加折线运动轨迹
			    // table data start 
			    var tabHTML="";
			    tabHTML+="<table class='map_data_tab'>";
			    tabHTML+="<thead>";
			    tabHTML+="<th>ID</th>";
			    tabHTML+="<th>接收时间</th>";
			    tabHTML+="<th>类型</th>";
			    tabHTML+="<th>经度</th>";
			    tabHTML+="<th>纬度</th>";
			    tabHTML+="</thead>";
			    tabHTML+="<tbody id='movies'>";
			    // table data end 
				for(i=0;i<result.length;i++)
			    {
					var id = result[i].id;				// 用户ID
					var recvdate = result[i].recvdate;	//接收日期时间
					var type = result[i].typ;			//类型 1:GPS, 2:LBS
			    	var lng = result[i].longitude;// 经度
			    	var lat = result[i].latitude;	// 纬度
			    	var cid = result[i].cid				//车辆编号
			    	//
			    	var point = new BMap.Point(lng, lat);	// 填充标注点
			    	if(i==0)
			    	{
			    		map.setCenter(point);							// 设置中心坐标
			    	}
			    	var tips = cid + "，" + recvdate + "，" + type;
			    	addMarker(point, map, tips);
			    	points.push(point);
			    	//
			    	tabHTML+="<tr onclick='openInfoWindow3(this,\""+lng+"\",\""+lat+"\")' style='cursor:pointer'>";
			    	tabHTML+="<td>";
			    	tabHTML+=id;
			    	tabHTML+="</td>";
			    	tabHTML+="<td>";
			    	tabHTML+=recvdate;
			    	tabHTML+="</td>";
			    	tabHTML+="<td>";
			    	var tp;
			    	if(type==1)
			    	{
						tp="GPS";
			    	}
			    	else
			    	{
				    	tp="LBS"
			    	}
			    	tabHTML+=tp;
			    	tabHTML+="</td>";
			    	tabHTML+="<td>";
			    	tabHTML+=lng;
			    	tabHTML+="</td>";
			    	tabHTML+="<td>";
			    	tabHTML+=lat;
			    	tabHTML+="</td>";
			    	tabHTML+="</tr>";
			    }
				var polyline = new BMap.Polyline(points);
				map.addOverlay(polyline); 								//绘制曲线

				//写数据
				tabHTML+="</tbody></table>";
				$("#mapdata").html(tabHTML);
				mypoints = points;
				bofang(points);
			}
		});
		return false;
	}
	
	//编写自定义函数,创建标注
	function addMarker(point, map, tips) 
	{
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
		
		//为标注添加文字信息
		var label = new BMap.Label(tips,{offset:new BMap.Size(20,-10)});
		//marker.setLabel(label);
		//为标记点添加事件
		//marker.addEventListener("click",attribute);
		var content="test";
		addClickHandler(content,marker);
	}

	var opts = {
			width : 250,     // 信息窗口宽度
			height: 100,     // 信息窗口高度
			title : "信息窗口" , // 信息窗口标题
			enableMessage:true//设置允许信息窗发送短息
		   };
	var addr;
	function addClickHandler(content,marker){
		marker.addEventListener("click",function(e){
			var pt = e.point;
			// 根据坐标得到地址描述
			geoc.getLocation(pt, function(rs){
				addr = rs.address;
				//var addComp = rs.addressComponents;
				//addr = addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber;
			});
			openInfo("车辆编号：1<br>最后在线时间：<br>地址:"+addr,e)}
			
		);
	}
	function openInfo(content,e){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
		map.openInfoWindow(infoWindow,point); //开启信息窗口
	}

	//
	//样式3
	//点击tr事件
	function openInfoWindow3(obj,lng,lat) {
		obj = $(obj);
		obj.addClass("ed").siblings().removeClass("ed");
		
		geoc.getLocation(new BMap.Point(lng,lat), function(rs){
			addr = rs.address;
		});
		
		var content="车辆编号:<br>最后在线时间:<br>定位时间:<br>定位类型:<br>经度:"+lng+"<br>纬度:"+lat+"<br>速度:<br>里程:<br>地址:"+addr;
		var searchInfoWindow3 = new BMapLib.SearchInfoWindow(map, content, {
			title: "信息框3", //标题
			width: 240, //宽度
			height: 140, //高度
			panel : "panel", //检索结果面板
			enableAutoPan : true, //自动平移
			searchTypes :[
			]
		});
		searchInfoWindow3.open(new BMap.Point(lng,lat));  
		//
	}
	//
	
	function bofang(points)
	{
		/********  play  ********/
		//通过DrivingRoute获取一条路线的point
		var driving = new BMap.DrivingRoute(map);
		//var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map}});
		driving.search(new BMap.Point(points[0].lng, points[0].lat), new BMap.Point(points[points.length-1].lng, points[points.length-1].lat));
		
		driving.setSearchCompleteCallback(function() {
			
			//得到路线上的所有point
			points = driving.getResults().getPlan(0).getRoute(0).getPath();
			//画面移动到起点和终点的中间
			
			centerPoint = new BMap.Point((points[0].lng + points[points.length - 1].lng) / 2, (points[0].lat + points[points.length - 1].lat) / 2);
			map.panTo(centerPoint);
			//连接所有点
			//map.addOverlay(new BMap.Polyline(points, {strokeColor: "#6993CF", strokeWeight: 5, strokeOpacity: 1}));
			
			//显示小车子
			label = new BMap.Label("", {offset: new BMap.Size(-20, -20)});
			car = new BMap.Marker(points[0], {icon: new BMap.Icon("images/car.png", new BMap.Size(48, 48), {imageOffset: new BMap.Size(0, 0)})});
			car.setLabel(label);
			map.addOverlay(car);
			
			//点亮操作按钮
			playBtn.disabled = false;
			resetBtn.disabled = false;
		});
		//
		var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/location.gif",new BMap.Size(14,23));
		driving.setMarkersSetCallback(function(result){
			//result[0].marker.setIcon(myIcon);
			//result[1].marker.setIcon(myIcon);
		});
		
	}
	
	function play() {
		playBtn.disabled = true;
		pauseBtn.disabled = false;
		
		var point = mypoints[index];
		if(index > 0) {
			//map.addOverlay(new BMap.Polyline([mypoints[index - 1], point], {strokeColor: "red", strokeWeight: 1, strokeOpacity: 1}));
		}
		label.setContent("经度: " + point.lng + "<br>纬度: " + point.lat);
		car.setPosition(point);
		index++;
		if(followChk.checked) {
			map.panTo(point);
		}
		if(index < mypoints.length) {
			timer = window.setTimeout("play(" + index + ")", 1000);
		} else {
			playBtn.disabled = true;
			pauseBtn.disabled = true;
			map.panTo(point);
		}
	}
	
	function pause() {
		playBtn.disabled = false;
		pauseBtn.disabled = true;
		
		if(timer) {
			window.clearTimeout(timer);
		}
	}
	
	function reset() {
		followChk.checked = false;
		playBtn.disabled = false;
		pauseBtn.disabled = true;
		
		if(timer) {
			window.clearTimeout(timer);
		}
		index = 0;
		car.setPosition(mypoints[0]);
		map.panTo(centerPoint);
	}
	//
</script>
</body>
</html>
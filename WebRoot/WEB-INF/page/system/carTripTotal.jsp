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
	#allmap {width:100%; height:600px;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">车辆行程统计</h3>
   	<form name="form1" action="<c:url value='car-triptotal.action'/>" method="post">
	<div class="queryDiv">
	   	<ul class="queryWrap_ul">
			<li><label>车牌号码：</label><input type="text" id="qchepaix" name="qchepai" class="ipt100 inputDefault"  value="${qchepai }"/></li>
	        <li><label>开始时间：</label><input type="text" id="sdttm" name="sdttm" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt140 inputDefault" value="${sessionScope.vts.cursdttm }" maxlength="20" style="height:18px"/></li>
	        <li><label>结束时间：</label><input type="text" id="edttm" name="edttm" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate ipt140 inputDefault" value="${sessionScope.vts.curedttm }" maxlength="20" style="height:18px"/></li>
	        <li><input type="submit" class="btn4" value="查&nbsp;&nbsp;询"/></li>
		</ul>
	</div>
    </form>
	<div id="allmap"></div>
</div>
<!-- ECharts单文件引入 -->
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
	// 路径配置
	require.config({
	    paths: {
	        echarts: 'http://echarts.baidu.com/build/dist'
	    }
	});
	
	// 使用
	require(
	    [
	        'echarts',
	        'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
	    ],
	    function (ec) {
	        // 基于准备好的dom，初始化echarts图表
	        var myChart = ec.init(document.getElementById('allmap')); 
	        
	       	var option = {
	        	    title: {
	        	        x: '',
	        	        text: '',
	        	        subtext: '',
	        	        link: ''
	        	    },
	        	    tooltip: {
	        	        trigger: 'item'
	        	    },
	        	    toolbox: {
	        	        show: true,
	        	        feature: {
	        	            dataView: {show: true, readOnly: false},
	        	            restore: {show: true},
	        	            saveAsImage: {show: true}
	        	        }
	        	    },
	        	    calculable: true,
	        	    grid: {
	        	        borderWidth: 0,
	        	        y: 80,
	        	        y2: 60
	        	    },
	        	    xAxis: [
	        	        {
	        	            type: 'category',
	        	            show: false,
	        	            data: ["行驶次数","最低电压","热车时长","怠速时长","行驶时长","行驶里程","怠速油耗","行驶油耗","最高转速","最高车速","加速次数","减速次数","转弯次数","平均油耗","总里程"]
	        	        }
	        	    ],
	        	    yAxis: [
	        	        {
	        	            type: 'value',
	        	            show: true
	        	        }
	        	    ],
	        	    grid : {
	    				x : '40px',
	    				y : '58px',
	    				width : '820px',
		    			height : '560px'
	    			},
	        	    series: [
	        	        {
	        	            name: '车辆行程统计',
	        	            type: 'bar',
	        	            itemStyle: {
	        	                normal: {
	        	                    color: function(params) {
	        	                        // build a color map as your need.
	        	                        var colorList = [
	        	                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
	        	                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
	        	                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
	        	                        ];
	        	                        return colorList[params.dataIndex]
	        	                    },
	        	                    label: {
	        	                        show: true,
	        	                        position: 'top',
	        	                        formatter: '{b}\n{c}'
	        	                    }
	        	                }
	        	            },
	        	            data: [${tripData }]
	        	        }
	        	    ]
	        	};
	
	        // 为echarts对象加载数据 
	        myChart.setOption(option); 
	    }
	);
	</script>
 	
</body>
</html>
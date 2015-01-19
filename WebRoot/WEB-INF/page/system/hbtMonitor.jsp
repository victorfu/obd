<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">驾驶习惯实时数据监测</h3>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
   	<div id="carMonitor" style="width:100%; height:100%"></div>
   	<input type="hidden" id="qchepaix" value="${qchepai }"/>
</div>
<!--  -->
<script type="text/javascript">
	$(function(){
		clearHbtCkData();
	});
</script>
<!-- ECharts单文件引入 -->
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript" language="javascript">
	var myChart;
	var eCharts;
	require.config({
		paths : {
			'echarts' : 'http://echarts.baidu.com/build/dist'
		}
	});
	require(
		[ 'echarts', 
		  'echarts/chart/line'
		], DrawEChart //异步加载的回调函数绘制图表
	);
	//创建ECharts图表方法
	function DrawEChart(ec) {
		eCharts = ec;
		myChart = eCharts.init(document.getElementById('carMonitor'));
		myChart.showLoading({
			text : "图表数据正在努力加载..."
		});
		//定义图表options
		var options = {
			title : {
				text : "",
				subtext : "",
				sublink : ""
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : ['']
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : false
					},
					dataView : {
						show : false,
						readOnly : false
					},
					magicType : {
						show : false,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : false
					},
					saveAsImage : {
						show : false
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				boundaryGap : false,
				data : ['0']
			} ],
			yAxis : [ {
				type : 'value',
				axisLabel : {
					formatter : '{value}'
				},
				splitArea : {
					show : true
				}
			} ],
			grid : {
				x:'40px',
				y:'58px',
				width : '820px'
			},
			series : [ {
				name : '',
				type : 'line',
				data : [0]//必须是Integer类型的,String计算平均值会出错
			} ]
		};
		myChart.setOption(options); //先把可选项注入myChart中
		myChart.hideLoading();
		//getChartData();//aja后台交互 
	}
</script>
<script type="text/javascript" src="<c:url value='js/cookie.js?v=1'/>"></script>
<script type="text/javascript">
	var interval;
	var curid=0;
	var qchepai = $("#qchepaix").val();
	$(function(){
		var time= 6000;
	    function run(){
			interval=setInterval(fun,time);
	    }
	    
	    function fun(){
	    	//获得图表的options对象
			var options = myChart.getOption();

			//通过Ajax获取数据
			$.ajax({
				type : "post",
				async : false, //同步执行
				url : "gethbtdata.action",
				data : {curid:curid, qchepai:qchepai},
				dataType : "json", //返回数据形式为json
				success : function(result) {
					if (result) {
						curid = result.curid;
						var rec = getCkData("hbt","rec",result.rec);
						//
						var tot = getCkData("hbt","tot",result.tot);
						var acct = getCkData("hbt","acct",result.acct);
						var acci = getCkData("hbt","acci",result.acci);
						var aveh = getCkData("hbt","aveh",result.aveh);
						var aves = getCkData("hbt","aves",result.aves);
						var maxs = getCkData("hbt","maxs",result.maxs);
						var hig = getCkData("hbt","hig",result.hig);
						var acce = getCkData("hbt","acce",result.acce);
						var tde = getCkData("hbt","tde",result.tde);
						var tsw = getCkData("hbt","tsw",result.tsw);
						//
						if(rec!=null)
						{
							var ca = {"category":rec.split(",")}
							var le = {"legend":["总点火次数","累计行驶时间","累计怠速时间","平均热车时间","平均车速","最高车速","最高转速","累计急加速","累计急减速","累计急转弯"]};
							var s = {"series":
										[
											{"name":"总点火次数","type":"line","data":tot.split(",")},
											{"name":"累计行驶时间","type":"line","data":acct.split(",")},
											{"name":"累计怠速时间","type":"line","data":acci.split(",")},
											{"name":"平均热车时间","type":"line","data":aveh.split(",")},
											{"name":"平均车速","type":"line","data":aves.split(",")},
											{"name":"最高车速","type":"line","data":maxs.split(",")},
											{"name":"最高转速","type":"line","data":hig.split(",")},
											{"name":"累计急加速","type":"line","data":acce.split(",")},
											{"name":"累计急减速","type":"line","data":tde.split(",")},
											{"name":"累计急转弯","type":"line","data":tsw.split(",")}
										]
									};
							options.legend.data = le.legend;
							options.xAxis[0].data = ca.category;
							options.series = s.series;
							if(result.isgetdata==true)
							{
								myChart.hideLoading();
								myChart.setOption(options);
							}
							else
							{
								console.log("stop draw echarts!");
							}
							console.log(rec.length);
							if(rec.length>50)
							{
								clearHbtCkData();
							}
						}
					}
				},
				error : function(errorMsg) {
					//alert("不好意思，大爷，图表请求数据失败啦!");
					myChart.hideLoading();
				}
			});
	    };
	    run();
	    //interval=window.clearInterval(interval);
	});	


	function clearHbtCkData()
	{
		Cookie.clearCookie("hbt_rec");	
		Cookie.clearCookie("hbt_tot");
		Cookie.clearCookie("hbt_acct");
		Cookie.clearCookie("hbt_acci");
		Cookie.clearCookie("hbt_aveh");
		Cookie.clearCookie("hbt_aves");
		Cookie.clearCookie("hbt_maxs");
		Cookie.clearCookie("hbt_hig");
		Cookie.clearCookie("hbt_acce");
		Cookie.clearCookie("hbt_tde");
		Cookie.clearCookie("hbt_tsw");
	}	
</script>
</body>
</html>
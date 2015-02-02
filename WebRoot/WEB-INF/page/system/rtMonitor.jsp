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
	<h3 class="h3_title">车辆实时数据监测
	<span><input type="button" value="返回" onclick="history.go(-1)" class="btn4"/></span>
	</h3>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
   	<div id="carMonitor" style="width:100%; height:100%"></div>
   	<input type="hidden" id="qchepaix" value="${qchepai }"/>
</div>

<script type="text/javascript">
	$(function(){
		clearRtCkData();
	});
</script>
<!-- ECharts单文件引入 -->
<script src="${pageContext.request.contextPath }/echarts/dist/echarts.js"></script>
<script type="text/javascript" language="javascript">
	var myChart;
	var eCharts;
	require.config({
		paths : {
			'echarts' : '${pageContext.request.contextPath }/echarts/dist'
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
				url : "getrtdata.action",
				data : {curid:curid, qchepai:qchepai},
				dataType : "json", //返回数据形式为json
				success : function(result) {
					if (result) {
						curid = result.curid;
						var rec = getCkData("rt","rec",result.rec);
						var vol = getCkData("rt","vol",result.vol);
						var engs = getCkData("rt","engs",result.engs);
						var run = getCkData("rt","run",result.run);
						var sol = getCkData("rt","sol",result.sol);
						var engl = getCkData("rt","engl",result.engl);
						var coo = getCkData("rt","coo",result.coo);
						var cre = getCkData("rt","cre",result.cre);
						var ave = getCkData("rt","ave",result.ave);
						var mil = getCkData("rt","mil",result.mil);
						var tot = getCkData("rt","tot",result.tot);
						var fue = getCkData("rt","fue",result.fue);
						var accu = getCkData("rt","accu",result.accu);
						var err = getCkData("rt","err",result.err);
						var acce = getCkData("rt","acce",result.acce);
						var dec = getCkData("rt","dec",result.dec);
						//
						if(rec!=null)
						{
							var ca = {"category":rec.split(",")}
							var le = {"legend":["电瓶电压","发动机转速","行驶车速","节气门开度","发动机负荷","冷却液温度","瞬时油耗","平均油耗","本次行驶里程","总里程","本次耗油量","累计耗油量","故障码数量","本次急加速","本次急减速"]};
							var s = {"series":
								[
									{"name":"电瓶电压","type":"line","data":vol.split(",")},
									{"name":"发动机转速","type":"line","data":engs.split(",")},
									{"name":"行驶车速","type":"line","data":run.split(",")},
									{"name":"节气门开度","type":"line","data":sol.split(",")},
									{"name":"发动机负荷","type":"line","data":engl.split(",")},
									{"name":"冷却液温度","type":"line","data":coo.split(",")},
									{"name":"瞬时油耗","type":"line","data":cre.split(",")},
									{"name":"平均油耗","type":"line","data":ave.split(",")},
									{"name":"本次行驶里程","type":"line","data":mil.split(",")},
									{"name":"总里程","type":"line","data":tot.split(",")},
									{"name":"本次耗油量","type":"line","data":fue.split(",")},
									{"name":"累计耗油量","type":"line","data":accu.split(",")},
									{"name":"故障码数量","type":"line","data":err.split(",")},
									{"name":"本次急加速","type":"line","data":acce.split(",")},
									{"name":"本次急减速","type":"line","data":dec.split(",")}
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
							console.log("rt rec length:"+rec.length);
							if(rec.length>200)
							{
								console.log("rt rec length gt 200");
								clearRtCkData();
								console.log("clear rt cookie data complete");
							}
						}
						else
						{
							console.log("res is null");
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

	function clearRtCkData()
	{
		Cookie.clearCookie("rt_rec");	
		Cookie.clearCookie("rt_tot");
		Cookie.clearCookie("rt_acct");
		Cookie.clearCookie("rt_acci");
		Cookie.clearCookie("rt_aveh");
		Cookie.clearCookie("rt_aves");
		Cookie.clearCookie("rt_maxs");
		Cookie.clearCookie("rt_hig");
		Cookie.clearCookie("rt_acce");
		Cookie.clearCookie("rt_tde");
		Cookie.clearCookie("rt_tsw");
	}	
</script>
</body>
</html>
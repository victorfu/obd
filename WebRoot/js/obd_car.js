$(function(){
	$("#chepaix").bind("blur",checkChepai);
	$("#devnox").bind("blur",checkDevno);
});

function checkChepai()
{
	var chep = $("#chepaix").val().trim();
	var reg = /^[\u4E00-\u9FA5][\da-zA-Z]{6}$/;
	chep = removeHTMLTag(chep);
	if(!chep || !reg.test(chep))
	{
		$(".asterisk")[0].innerHTML="车牌号格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}

function checkDevno()
{
	var d = $("#devnox").val();
	var b = true;
	if(d)
	{
		$.ajax({
			cache: false,
			async: false,
			type: "POST",
			dataType: "json",
			data: {devno:d},
			url: "checkEnableDev.action",
			success: function(flag) {
				if(!flag) {
					b = false;	
					alert("设备不存在！");
				}
			}
		});
	}
	else
	{
		b = true;
	}
	console.log("b:"+b);
	return b;
}


//add car
function saveCar(roleid,s,cid,devno,pinpai,xinghao,buydt,chepai,chejia,fadong,color,tip,warn)
{
	$(".asterisk").each(function(){
		this.innerHTML="";
	});
	$(".asterisk")[0].innerHTML="*";
	//
	//init
	$("#istipchk")[0].checked=false;
	$("#iswarnchk")[0].checked=false;
	if(roleid!=4)
	{
		$("#devnox")[0].disabled=false;
		$("#lab_devnox_r")[0].disabled=false;
	}
	else
	{
		$("#devnox")[0].style.display="block";
	}
	//
	var tit;
	if(s==0)
	{
		tit="添加车辆";
	}
	else
	{
		tit="修改车辆信息";
	}
	//
	$("#cidx").val(cid);
	$("#devnox").val(devno);
	$("#pinpaix").val(pinpai);
	$("#xinghaox").val(xinghao);
	$("#buydtx").val(buydt);
	$("#chepaix").val(chepai);
	$("#chejiax").val(chejia);
	$("#fadongx").val(fadong);
	$("#colorx").val(color);
	$("#tipx").val(tip);
	$("#warnx").val(warn);

	//checkbox tip,warn
	if(tip==1){$("#istipchk")[0].checked=true;}else{$("#istipchk")[0].checked=false;}
	if(warn==1){$("#iswarnchk")[0].checked=true;}else{$("#iswarnchk")[0].checked=false;}
	//
	if(roleid!=4)
	{
		
		if(devno.length==0)
		{
			$("#lab_devx")[0].style.display="none";
			$("#devnox")[0].style.display="block";
			$("#lab_devnox_r")[0].disabled=true;
		}
		else
		{
			$("#lab_devx")[0].style.display="block";
			$("#lab_devx")[0].innerHTML=devno;
			$("#devnox")[0].style.display="none";
			//
			$("#lab_devnox_r").val(devno);
			$("#devnox")[0].disabled=true;
		}
	}
	else
	{
		if(devno.length==0)
		{
			$("#lab_devx")[0].style.display="none";
			$("#devnox")[0].style.display="block";
		}
		else
		{
			$("#lab_devx")[0].style.display="block";
			$("#lab_devx")[0].innerHTML=devno;
			$("#devnox")[0].style.display="none";
		}
	}
	//
	$.layer({
		type: 1,
        title: tit,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','440px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popSaveCarDiv'}
	});
}

function saveCarBtn(roleid)
{
	if(roleid==4)
	{
		if(!checkDevno()) return false;
	}
	if(!checkChepai())	return false;
	//
	$("#form2").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			if(data=="0")
			{
				//alert("保存成功");
				document.form1.submit();
			}
			else if(data=="-1")
			{
				alert("车牌号已经存在");
			}
			else
			{
				alert("请求失败");
			}
        }
	});
    return false;
}

//delete device
function deleteCar(cid,index)
{
	//tbody
	var tab = document.getElementById("movies");
	//tr 
	var row = document.getElementById("rowIndex_"+index);
	//
	var m=confirm("你确定要删除吗?"); 
	if(m==true)
	{ 
		$.ajax({
			cache:false,
			async:false,
			type:"post",
			data:{cid:cid},
			url:"deleteCar.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}
//
function checkTip(obj)
{
	if(obj.checked)
	{
		$("#tipx").val(1);
	}
	else
	{
		$("#tipx").val(0);
	}
}
function checkWarn(obj)
{
	if(obj.checked)
	{
		$("#warnx").val(1);
	}
	else
	{
		$("#warnx").val(0);
	}
}

//解除绑定
function unbindDev(cid,devno)
{
	$("#row_devno"+cid)[0].innerHTML="";
	var pg = $("#page_car_g").val();
	$("#pageflag_query").val(pg);
	//
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{cid:cid,devno:devno},
		url:"unbindDev.action",
		success: function(data) {
			document.form1.submit();
		}
	});
}
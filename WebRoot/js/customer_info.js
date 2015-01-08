//保存客户资料验证 start
$(function(){
	$("#pinox").bind("blur",checkPino);
	$("#caryearx").bind("blur",checkCaryear);
	$("#chuxcsx").bind("blur",checkChuxcs);
	$("#idcardx").bind("blur",checkIdcard);
	$("#mobilex").bind("blur",checkMobile);
	$("#hometelx").bind("blur",checkHometel);
	$("#officetelx").bind("blur",checkOfficetel);
});
//导入批次
function checkPino()
{
	var p = $("#pinox").val();
	if(!p)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="导入批次不能为空！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//车龄
function checkCaryear()
{
	var reg = /^[0-9]*[0-9][0-9]*$/;
	var c = $("#caryearx").val();
	if(!reg.exec(c))
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的车龄,如2014！";
		return false;
	}
	else if(c<0 || c>9999)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的车龄,如2014！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//出险次数
function checkChuxcs()
{
	var reg = /^[0-9]*[0-9][0-9]*$/;
	var c = $("#chuxcsx").val();
	if(!reg.exec(c))
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的出险次数,车龄范围[0-1000]！";
		return false;
	}
	else if(c<0 || c>1000)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的车龄,车龄范围[0-1000]！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//身份证号
function checkIdcard()
{
	var reg = /\d{17}[\d|x]|\d{15}/;
	var i = $("#idcardx").val();
	if(!reg.exec(i) && i)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的身份证号！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//手机
function checkMobile()
{
	//var reg = /0?(13|14|15|18)[0-9]{9}/;
	var reg = /^[0-9]*$/;
	var m = $("#mobilex").val();
	if(!reg.exec(m) && m && m.length<20)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的手机号！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//家庭电话
function checkHometel()
{
	//var reg = /^([0-9]|[-])+$/g;
	var reg = /^[0-9]*$/;
	var h = $("#hometelx").val();
	if(!reg.exec(h) && h && h.length<20)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的家庭电话！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//办公电话
function checkOfficetel()
{
	//var reg = /^([0-9]|[-])+$/g;
	var reg = /^[0-9]*$/;
	var h = $("#officetelx").val();
	if(!reg.exec(h) && h && h.length<20)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="请输入合理的办公电话！";
		return false;
	}
	else
	{
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		return true;
	}
}

//保存信息
function saveCustomerBtn()
{
	if(!checkPino()) return;
	if(!checkCaryear()) return;
	if(!checkChuxcs()) return;
	if(!checkIdcard()) return;
	if(!checkMobile()) return;
	if(!checkHometel()) return;
	if(!checkOfficetel()) return;
	//
	$("#form2").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			alert("保存成功");	
        }  
	}); 
    return false;

}





//保存客户资料验证 end

//设置预约时间
function setYuyDateTime(cid,yflag)
{
	var dt = $("#yuydatex").val();
	if(!dt)
	{
		$("#error_msg").css("display","block");
		$("#error_msg")[0].innerHTML="预约日期时间不能为空！";
		return false;
	}
	else
	{
		var yd = dt.substring(0,10);
		var yt = dt.substring(11,19);
		$("#error_msg").css("display","none");
		$("#error_msg")[0].innerHTML="";
		$.ajax({
			cache:false,
			async:false,
			type:"post",
			data:{cid:cid,yuydate:yd,yuytime:yt,yuyflag:yflag},
			url:"setYuydt.action",
			success: function(data) {
				alert("设置预约时间成功！");
			}
		});
	}
}

//取消预约时间
function cancelYuyDateTime(cid,yflag)
{
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{cid:cid,yuyflag:yflag},
		url:"setYuydt.action",
		success: function(data) {
			$("#yuydatex").val("");
			alert("取消预约时间成功！");
		}
	});
}
/*****************************************************************************************/
/*************************************** 弹屏 ********************************************/
/*****************************************************************************************/
//保存
function saveTanpinBtn()
{
	if(!checkCaryear()) return;
	if(!checkChuxcs()) return;
	if(!checkIdcard()) return;
	if(!checkMobile()) return;
	if(!checkHometel()) return;
	if(!checkOfficetel()) return;
	//
	$("#form2").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			alert("保存成功");	
        }  
	}); 
    return false;
}

/**************************************************************/
/************************* call *******************************/
/**************************************************************/

function addCallTime(cid)
{
	var datajson = {"cid":cid};
	var url = 'addCallTime.action';
	$.ajax({
        type: "POST",
        url: url,
        data: datajson,
        success: function(){
			//alert("设置成功");
        },
        error: function () {
        	//alert("设置失败");
        }
    });
}
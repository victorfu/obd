$(function(){
	$("#tpnamex").bind("blur",checkDevTypeName);
	$("#changjx").bind("blur",checkChangj);
	$("#addrx").bind("blur",checkAddr);
	$("#telnumx").bind("blur",checkTelnum);
	$("#mobilex").bind("blur",checkMobile);
	$("#qqx").bind("blur",checkQQ);
	$("#emailx").bind("blur",checkEmail);
	$("#cjurlx").bind("blur",checkCjurl);
});

//类型名称
function checkDevTypeName()
{
	var tpname = $("#tpnamex").val().trim();
	tpname = removeHTMLTag(tpname);
	if(!tpname)
	{
		$(".asterisk")[0].innerHTML="类型名称格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}

function checkChangj()
{
	var cj = $("#changjx").val();	
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(cj))
	{
		$(".asterisk")[1].innerHTML="厂家格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[1].innerHTML="";
		return true;
	}
}
function checkAddr()
{
	var ad = $("#addrx").val();	
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(ad))
	{
		$(".asterisk")[2].innerHTML="地址格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[2].innerHTML="";
		return true;
	}
}

//电话号码
function checkTelnum()
{
	var telnum = $("#telnumx").val();
	var reg = /^([0-9]|[-])+$/g;
	if(telnum && !reg.exec(telnum))
	{
		$(".asterisk")[3].innerHTML="请输入合理的电话号码！";
		return false;
	}
	else
	{
		$(".asterisk")[3].innerHTML="";
		return true;
	}
}
//手机号
function checkMobile()
{
	var mobile = $("#mobilex").val();
	var reg = /0?(13|14|15|18)[0-9]{9}/;
	if(mobile && !reg.exec(mobile))
	{
		$(".asterisk")[4].innerHTML="请输入合理的手机号！";
		return false;
	}
	else
	{
		$(".asterisk")[4].innerHTML="";
		return true;
	}
}
//QQ号
function checkQQ()
{
	var qq = $("#qqx").val();
	var reg = /^[0-9]*[0-9][0-9]*$/;
	if(qq && !reg.exec(qq))
	{
		$(".asterisk")[5].innerHTML="请输入合理的QQ号！";
		return false;
	}
	else
	{
		$(".asterisk")[5].innerHTML="";
		return true;
	}
}
//Email
function checkEmail()
{
	var email = $("#emailx").val();
	var reg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
	if(email && !reg.exec(email))
	{
		$(".asterisk")[6].innerHTML="请输入合理的Email号！";
		return false;
	}
	else
	{
		$(".asterisk")[6].innerHTML="";
		return true;
	}
}

function checkCjurl()
{
	var cju = $("#cjurlx").val();
	if(cju && !IsURL(cju))
	{
		$(".asterisk")[7].innerHTML="请输入合理的网址！";
		return false;
	}
	else
	{
		$(".asterisk")[7].innerHTML="";
		return true;
	}
}

function IsURL(str_url){ 
	var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
		  + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
		  + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
		  + "|" // 允许IP和DOMAIN（域名） 
		  + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
		  + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
		  + "[a-z]{2,6})" // first level domain- .com or .museum  
		  + "(:[0-9]{1,4})?" // 端口- :80  
		  + "((/?)|" // a slash isn't required if there is no file name  
		  + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
	var re=new RegExp(strRegex);
	if (re.test(str_url)){ 
		return true;  
	}else{  
		return false;  
	} 
} 
//save device type
function saveType(s,typeno,tpname,changj,addr,telnum,mobile,qq,email,cjurl)
{
	//init
	$(".asterisk").each(function(){
		this.innerHTML="";
	});
	$(".asterisk")[0].innerHTML="*";
	//
	var tit;
	if(s==0)
	{
		tit="添加设备类型";
	}
	else
	{
		tit="修改设备类型";
	}
	//
	$("#typenox").val(typeno);
	$("#tpnamex").val(tpname);
	$("#changjx").val(changj);
	$("#addrx").val(addr);
	$("#telnumx").val(telnum);
	$("#mobilex").val(mobile);
	$("#qqx").val(qq);
	$("#emailx").val(email);
	$("#cjurlx").val(cjurl);
	//
	$.layer({
		type: 1,
        title: tit,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','400px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popSaveTypeDiv'}
	});
}

function saveTypeBtn()
{
	if(!checkDevTypeName()) return false;
	if(!checkChangj()) return false;
	if(!checkAddr()) return false;
	if(!checkTelnum()) return false;
	if(!checkMobile()) return false;
	if(!checkQQ()) return false;
	if(!checkEmail()) return false;
	if(!checkCjurl()) return false;
	document.form2.submit();
}

//delete device
function deleteType(typeno,index)
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
			data:{typeno:typeno},
			url:"deleteDevType.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}

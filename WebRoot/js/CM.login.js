function login(){
	var account = $("#account").val();
	var password = $("#password").val();
	var vercode = $("#vercode").val();
	if(!account)
	{
		alert("账号不能为空",111);
		return false;
	}
	if(!password)
	{
		alert("密码不能为空",111);
		return false;
	}
	if(!vercode)
	{
		alert("请输入验证码",111);
		return false;
	}
	var datajson = {"account":account, "password":password,"vercode":vercode};
	var url = 'ajaxlogin.action';
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: responseLogin,
        error: function () {
            //alert(RES.REQUESTWRONG);
        }
    });
}

var responseLogin = function(data, textStatus, jqXHR)
{
	if(data.status=="ok")
	{
		if($('#rememberPass').is(':checked'))
		{
			Cookie.setCookie("account_obd",$("#account").val());
			Cookie.setCookie("password_obd",$("#password").val());
		}
		else
		{
			Cookie.clearCookie("account_obd");	
			Cookie.clearCookie("password_obd");
		}
		window.location.href="user-home.action";
	}
	else if(data.status=="vercodeerror")
	{
		alert("验证码错误,请重新输入!");
	}
	else
	{
		alert("账号或密码错误");
	}
	verImg.src = "verCode?"+Math.random();
}

$(function(){
	$("#verImg").bind("click",changeVerCode);
});
//
function changeVerCode()
{
	verImg.src = "verCode?"+Math.random();
}
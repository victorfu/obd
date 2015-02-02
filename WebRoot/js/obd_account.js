$(function(){
	$("#uaccx").bind("blur",checkUacc);
	$("#unamex").bind("blur",checkUname);
});
//账号
function checkUacc()
{
	var a = $("#uaccx").val();
	var al = a.length;
	var h = /^[A-Za-z]{1}([A-Za-z0-9]){0,19}$/;
	var bool = false;
	if(!a)
	{
		$("#accErrMsg")[0].innerHTML="账号不能为空";
		bool = false;
	}
	if(!h.test(a))
	{
		$("#accErrMsg")[0].innerHTML="账号由字母、数字组成,首位必须为字母";
		bool = false;
	}
	if(al<6 || al>20)
	{
		$("#accErrMsg")[0].innerHTML="账号长度为6~20位";
		bool = false;
	}
	//
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{account:a},
		url:"ansyUserName.action",
		success: function(result) {
			if(result=="0")
			{
				$("#accErrMsg")[0].innerHTML="";
				bool = true;
			}
			else if(result=="1")
			{
				$("#accErrMsg")[0].innerHTML="账号已存在!";
				bool = false;
			}
			else
			{
				alert("请求失败!");
				bool = false;
			}
		}
	});
	return bool;
}


//用户姓名
function checkUname()
{
	var n = $("#unamex").val();
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(!n)
	{
		$("#nameErrMsg")[0].innerHTML="用户姓名不能为空";
		return false;
	}
	else if(reg.test(n))
	{
		$("#nameErrMsg")[0].innerHTML="用户姓名不能包含特殊字符";
		return false;
	}
	else
	{
		$("#nameErrMsg")[0].innerHTML="";
		return true;
	}
}

//add device
function addAccount()
{
	//init
	$("#accErrMsg")[0].innerHTML="";
	$("#nameErrMsg")[0].innerHTML="";
	//
	$.layer({
		type: 1,
        title: "添加用户",
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['430px','300px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popAddAccountDiv'}
	});
}

function addAccountBtn()
{
	if(!checkUacc()) return false;
	if(!checkUname()) return false;
	document.form2.submit();
}

//delete device
function deleteAccount(uid,index)
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
			data:{uid:uid},
			url:"deleteAccount.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}


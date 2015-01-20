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
	if(!a)
	{
		$("#accErrMsg")[0].innerHTML="账号不能为空";
		return false;
	}
	if(!h.test(a))
	{
		$("#accErrMsg")[0].innerHTML="账号由字母、数字组成,首位必须为字母";
		return false;
	}
	if(al<6 || al>20)
	{
		$("#accErrMsg")[0].innerHTML="账号长度为6~20位";
		return false;
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
				return true;
			}
			else if(result=="1")
			{
				$("#accErrMsg")[0].innerHTML="账号已存在!";
				return false;
			}
			else
			{
				alert("请求失败!");
				return false;
			}
		}
	});
}


//用户姓名
function checkUname()
{
	var n = $("#unamex").val().trim();
	if(!n)
	{
		$("#nameErrMsg")[0].innerHTML="用户姓名不能为空";
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

//保存用户
function saveAccount()
{
	var uid = $("#uidx").val();
	var aid = $("#aidx").val();
	var ulevel = $("#ulevelx").val();
	
	var uacc = $("#uaccx").val();
	var uname = $("#unamex").val();
	var idcard = $("#idcardx").val();
	var idcardtype = $("#idcardtypex").val();
	var qq = $("#qqx").val();
	var email = $("#emailx").val();
	var photo = $("#photox").val();
	var addr = $("#addrx").val();
	var telnum = $("#telnumx").val();
	var mobile = $("#mobilex").val();
	var noteinfo = $("#noteinfox").val();
	//
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{uid:uid, aid:aid, ulevel:ulevel, uacc:uacc, uname:uname, idcard:idcard, idcardtype:idcardtype, qq:qq, email:email, photo:photo, addr:addr, telnum:telnum, mobile:mobile, noteinfo:noteinfo},
		url:"saveAccount.action",
		success: function(data) {
			alert("保存成功");
		}
	});
}


//add device
function addAccount()
{
	$.layer({
		type: 1,
        title: "添加用户",
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','240px'],
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

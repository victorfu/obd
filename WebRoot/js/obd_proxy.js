$(function(){
	$("#pnamex").bind("blur",checkPname);
});
//代理商姓名
function checkPname()
{
	var pn = $("#pnamex").val().trim();
	if(!pn)
	{
		$(".asterisk")[0].innerHTML="代理商姓名不能为空！";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}


//是否启用
function checkEnable(obj)
{
	if(obj.checked)
	{
		$("#ienablex").val(1);
	}
	else
	{
		$("#ienablex").val(0);	
	}
}

//add device
function saveProxy(s,aid,pname,ienable,addr,telnum,mobile,qq,url,paid,company,mode,ptype,sdt,edt,img,money,email)
{
	//init
	$(".asterisk").each(function(){
		this.innerHTML="";
	});
	//
	var tit;
	if(s==0)
	{
		tit="添加代理商";
	}
	else
	{
		tit="修改代理商信息";
	}
	//
	$("#aidx").val(aid);
	$("#pnamex").val(pname);
	$("#ienablex").val(ienable);
	if(ienable==1)
	{
		$("#ienablechk")[0].checked=true;
	}
	else
	{
		$("#ienablechk")[0].checked=false;
	}
	
	$("#addrx").val(addr);
	$("#telnumx").val(telnum);
	$("#mobilex").val(mobile);
	$("#qqx").val(qq);
	$("#urlx").val(url);
	$("#paidx").val(paid);
	$("#companyx").val(company);
	$("#modex").val(mode);
	$("#ptypex").val(ptype);
	$("#sdtx").val(sdt);
	$("#edtx").val(edt);
	$("#imgx").val(img);
	$("#moneyx").val(money);
	$("#emailx").val(email);
	$.layer({
		type: 1,
        title: tit,
        offset: [10+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','650px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popSaveProxyDiv'}
	});
}

function saveProxyBtn()
{
	if(!checkPname()) return false;
	document.form2.submit();
}

//delete device
function deleteProxy(aid,index)
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
			data:{aid:aid},
			url:"deleteProxy.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}

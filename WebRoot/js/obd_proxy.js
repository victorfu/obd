
//add device
function saveProxy(s,aid,pname,ienable,addr,telnum,mobile,qq,url,paid,company,mode,ptype,sdt,edt,img,money,email)
{
	//init
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

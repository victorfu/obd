//save device type
function saveType(s,typeno,tpname,changj,addr,telnum,mobile,qq,email,cjurl)
{
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

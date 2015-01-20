$(function(){
	$("#devnox").bind("blur",checkDevno);
});

function checkDevno()
{
	var devno = $("#devnox").val().trim();
	if(!devno)
	{
		$(".asterisk")[0].innerHTML="设备号不能为空";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}
//devnox


//show select file dialog
function showSelFile()
{
	$.layer({
		type: 1,
        title: '导入数据',
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['400px','150px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popImportDataDiv'}
	});
}

//submit form
function validateuploadInforFile(form)
{
	$(".asterisk")[1].innerHTML="";
	if(!validateExcelUpLoadFile(form)) return false;
	var f = $("#uploadExcel").val();
	var index = f.lastIndexOf("\\",f.length);
	if(parseInt(index)>0)
		f = f.substring(index+1, f.length);
	layer.closeAll();
	layer.load("正在导入【"+f+"】...",0);
	$("#form3").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			document.form1.submit();
	    }  
	}); 
	return false;	//not refresh page
}

//导入Excel文件时进行文件格式校验 
function validateExcelUpLoadFile(form)
{
	var fileName = form.uploadExcel.value;
	if (fileName != "" ) {
		var fileType = (fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length)).toLowerCase();
		var suppotFile = ["xls", "XLS", "xlsx", "XLSX"];
		for (var i = 0; i < suppotFile.length; i++) {
			if (suppotFile[i] == fileType) {
				return true;
			} else {
				continue;
			}
		}
		$(".asterisk")[1].innerHTML="文件格式不正确！";
		return false;
	} else {
		$(".asterisk")[1].innerHTML="请选择你需要导入的文件";
		return false;
	}	
}

//add device
function saveDevice(s,devno,type,state,changj,devxh,valdt,identi)
{
	//init
	$(".asterisk").each(function(){
		this.innerHTML="";
	});
	$(".asterisk")[0].innerHTML="*";
	
	//
	$("#is_show_devstate")[0].style.display="none";
	//
	var tit;
	if(s==0)
	{
		tit="添加设备";
		$("#is_show_devstate")[0].style.display="none";
	}
	else
	{
		tit="修改设备信息";
		$("#is_show_devstate")[0].style.display="block";
	}
	//
	$("#devnox").val(devno);
	$("#typex").val(type);
	$("#statex").val(state);
	$("#changjx").val(changj);
	$("#devxhx").val(devxh);
	$("#valdtx").val(valdt);
	$("#identix").val(identi);
	$.layer({
		type: 1,
        title: tit,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','370px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popSaveDeviceDiv'}
	});
}

function saveDeviceBtn()
{
	if(!checkDevno()) return false;
	document.form2.submit();
}

//delete device
function deleteDevice(dsn,index)
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
			data:{devno:dsn},
			url:"deleteDev.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}

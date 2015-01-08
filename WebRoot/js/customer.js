// 保存批次号
function savePiNo(t,pino,noteinfo)
{
	//init
	$("#pinox").show();
	document.getElementById("pinox").type="text";
	//$("#pinox").attr("type","text");
	$(".asterisk")[0].innerHTML="";
	$("#pinolabel")[0].innerHTML="";
	//
	var tit;
	if(t=="add")
	{
		tit="添加批次号";
	}
	else
	{
		tit="修改批次号";
		$("#pinox").hide();
		$("#pinolabel")[0].innerHTML=pino;
	}
	//
	$("#pinox").val(pino);
	$("#noteinfox").val(noteinfo);
	//
	$.layer({
		type: 1,
        title: tit,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','280px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popPiNoDiv'}
	});
}

$(function(){
	$("#pinox").bind("blur",checkPino);
});

function checkPino()
{
	var pino = $("#pinox").val();
	if(!pino)
	{
		$(".asterisk")[0].innerHTML="批次号不能为空";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}

function savePiNoBtn()
{
	if(!checkPino()) return false;
	
	$("#form2").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			layer.closeAll();
			if(data=="ok")
			{
				document.form1.submit();
			}
			else
			{
				alert("保存批次号失败！");
			}
        }  
	}); 
    return false;	//not refresh page
}

//show select file dialog
function showSelFile(pino)
{
	$("#imp_pino").val(pino);
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

function clearPino(ids)
{
	$("#clear_pino").val(ids);
	layer.confirm("确定要清空吗？",function(){
		$("#form4").ajaxSubmit({ 
			success:function(data){ //提交成功的回调函数
				document.form1.submit();
	        }  
		}); 
	    return false;	//not refresh page
	});
}

function resetFenpei(ids)
{
	$("#reset_pino").val(ids);
	layer.confirm("确定要重置分配吗？",function(){
		$("#form5").ajaxSubmit({ 
			success:function(data){ //提交成功的回调函数
				document.form1.submit();
	        }  
		}); 
	    return false;	//not refresh page
	});
}

function deletePino(ids)
{
	$("#delete_pino").val(ids);
	layer.confirm("确定要删除吗？",function(){
		$("#form7").ajaxSubmit({ 
			success:function(data){ //提交成功的回调函数
				document.form1.submit();
	        }  
		}); 
	    return false;	//not refresh page
	});
}
//add car
function saveCar(s,cid,devno,pinpai,xinghao,buydt,chepai,chejia,fadong,color,tip,warn)
{
	//init
	$("#istipchk")[0].checked=false;
	$("#iswarnchk")[0].checked=false;
	$("#devnox")[0].disabled=false;
	$("#lab_devnox_r")[0].disabled=false;
	//
	var tit;
	if(s==0)
	{
		tit="添加车辆";
	}
	else
	{
		tit="修改车辆信息";
	}
	//
	$("#cidx").val(cid);
	$("#devnox").val(devno);
	$("#pinpaix").val(pinpai);
	$("#xinghaox").val(xinghao);
	$("#buydtx").val(buydt);
	$("#chepaix").val(chepai);
	$("#chejiax").val(chejia);
	$("#fadongx").val(fadong);
	$("#colorx").val(color);
	$("#tipx").val(tip);
	$("#warnx").val(warn);

	//checkbox tip,warn
	if(tip==1){$("#istipchk")[0].checked=true;}else{$("#istipchk")[0].checked=false;}
	if(warn==1){$("#iswarnchk")[0].checked=true;}else{$("#iswarnchk")[0].checked=false;}
	//
	if(devno.length==0)
	{
		$("#lab_devx")[0].style.display="none";
		$("#devnox")[0].style.display="block";
		$("#lab_devnox_r")[0].disabled=true;
	}
	else
	{
		$("#lab_devx")[0].style.display="block";
		$("#lab_devx")[0].innerHTML=devno;
		$("#devnox")[0].style.display="none";
		//
		$("#lab_devnox_r").val(devno);
		$("#devnox")[0].disabled=true;
	}
	//
	$.layer({
		type: 1,
        title: tit,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [5, 0.5, '#666'],
        area: ['450px','440px'],
        shadeClose: false,
		bgcolor: '#EEF1F8',
		page:{dom:'#popSaveCarDiv'}
	});
}

function saveCarBtn()
{
	document.form2.submit();
}

//delete device
function deleteCar(cid,index)
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
			data:{cid:cid},
			url:"deleteCar.action",
			success: function(data) {
				tab.deleteRow(row.sectionRowIndex);
			}
		});
	} 
	else
	{ 
		
	} 
}
//
function checkTip(obj)
{
	if(obj.checked)
	{
		$("#tipx").val(1);
	}
	else
	{
		$("#tipx").val(0);
	}
}
function checkWarn(obj)
{
	if(obj.checked)
	{
		$("#warnx").val(1);
	}
	else
	{
		$("#warnx").val(0);
	}
}

//解除绑定
function unbindDev(cid,devno)
{
	$("#row_devno"+cid)[0].innerHTML="";
	//
	$.ajax({
		cache:false,
		async:false,
		type:"post",
		data:{cid:cid,devno:devno},
		url:"unbindDev.action",
		success: function(data) {
			document.form1.submit();
		}
	});
}
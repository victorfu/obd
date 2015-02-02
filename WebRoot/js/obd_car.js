
$(function(){
	$("#chepaix").bind("blur",checkChepai);
	$("#devnox").bind("blur",checkDevno);
	$("#pinpaix").bind("blur",checkPinpai);
	$("#xinghaox").bind("blur",checkXinghao);
	$("#chejiax").bind("blur",checkChejia);
	$("#fadongx").bind("blur",checkFadong);
	$("#colorx").bind("blur",checkColor);
});

var Bind = function(object, fun) {
    return function() {
        return fun.apply(object, arguments);
    }
}
function AutoComplete(obj,autoObj,arr){
    this.obj=document.getElementById(obj);        //输入框
    this.autoObj=document.getElementById(autoObj);//DIV的根节点
    this.value_arr=arr;        //不要包含重复值
    this.index=-1;          //当前选中的DIV的索引
    this.search_value="";   //保存当前搜索的字符
}

var devStr;

AutoComplete.prototype={
    //初始化DIV的位置
    init: function(){
        this.autoObj.style.left = this.obj.offsetLeft + "px";
        this.autoObj.style.top  = this.obj.offsetTop + this.obj.offsetHeight + "px";
        this.autoObj.style.width= this.obj.offsetWidth - 2 + "px";//减去边框的长度2px
    },
    //删除自动完成需要的所有DIV
    deleteDIV: function(){
        while(this.autoObj.hasChildNodes()){
            this.autoObj.removeChild(this.autoObj.firstChild);
        }
        this.autoObj.className="auto_hidden";
    },
    //设置值
    setValue: function(_this){
        return function(){
            _this.obj.value=this.seq;
            _this.autoObj.className="auto_hidden";
        }
    },
    //模拟鼠标移动至DIV时，DIV高亮
    autoOnmouseover: function(_this,_div_index){
        return function(){
            _this.index=_div_index;
            var length = _this.autoObj.children.length;
            for(var j=0;j<length;j++){
                if(j!=_this.index ){
                    _this.autoObj.childNodes[j].className='auto_onmouseout';
                }else{
                    _this.autoObj.childNodes[j].className='auto_onmouseover';
                }
            }
        }
    },
    //更改classname
    changeClassname: function(length){
        for(var i=0;i<length;i++){
            if(i!=this.index ){
                this.autoObj.childNodes[i].className='auto_onmouseout';
            }else{
                this.autoObj.childNodes[i].className='auto_onmouseover';
                this.obj.value=this.autoObj.childNodes[i].seq;
            }
        }
    }
    ,
    //响应键盘
    pressKey: function(event){
        var length = this.autoObj.children.length;
        //光标键"↓"
        if(event.keyCode==40){
            ++this.index;
            if(this.index>length){
                this.index=0;
            }else if(this.index==length){
                this.obj.value=this.search_value;
            }
            this.changeClassname(length);
        }
        //光标键"↑"
        else if(event.keyCode==38){
            this.index--;
            if(this.index<-1){
                this.index=length - 1;
            }else if(this.index==-1){
                this.obj.value=this.search_value;
            }
            this.changeClassname(length);
        }
        //回车键
        else if(event.keyCode==13){
            this.autoObj.className="auto_hidden";
            this.index=-1;
        }else{
            this.index=-1;
        }
    },
    //程序入口
    start: function(event){
        if(event.keyCode!=13&&event.keyCode!=38&&event.keyCode!=40){
            this.init();
            this.deleteDIV();
            this.search_value=this.obj.value;
            var valueArr=this.value_arr;
            valueArr = ['b33','b32','b322','b333','b334','b335','b336'];
            valueArr = devStr.split(",");
            valueArr.sort();
            if(this.obj.value.replace(/(^\s*)|(\s*$)/g,'')==""){ return; }//值为空，退出
            try{ var reg = new RegExp("(" + this.obj.value + ")","i");}
            catch (e){ return; }
            var div_index=0;//记录创建的DIV的索引
            for(var i=0;i<valueArr.length;i++){
                if(reg.test(valueArr[i])){
                    var div = document.createElement("div");
                    div.className="auto_onmouseout";
                    div.seq=valueArr[i];
                    div.onclick=this.setValue(this);
                    div.onmouseover=this.autoOnmouseover(this,div_index);
                    div.innerHTML=valueArr[i].replace(reg,"<strong>$1</strong>");//搜索到的字符粗体显示
                    this.autoObj.appendChild(div);
                    this.autoObj.className="auto_show";
                    div_index++;
                }
            }
        }
        this.pressKey(event);
        window.onresize=Bind(this,function(){this.init();});
    }
}

var autoComplete=new AutoComplete('o','auto',['b0','b12','b22','b3','b4','b5','b6']);


function checkDevno()
{
	var d = $("#o").val();
	var b = true;
	if(d)
	{
		$.ajax({
			cache: false,
			async: false,
			type: "POST",
			dataType: "json",
			data: {devno:d},
			url: "checkEnableDev.action",
			success: function(flag) {
				if(!flag) {
					b = false;	
					alert("设备不存在！");
				}
			}
		});
	}
	else
	{
		b = true;
	}
	//console.log("b:"+b);
	return b;
}

function checkChepai()
{
	var chep = $("#chepaix").val();
	var reg = /^[\u4E00-\u9FA5][\da-zA-Z]{6}$/;
	chep = removeHTMLTag(chep);
	if(!chep || !reg.test(chep))
	{
		$(".asterisk")[0].innerHTML="车牌号格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[0].innerHTML="";
		return true;
	}
}
function checkPinpai()
{
	var pp = $("#pinpaix").val();
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(pp))
	{
		$(".asterisk")[1].innerHTML="品牌格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[1].innerHTML="";
		return true;
	}
}
function checkXinghao()
{
	var xh = $("#xinghaox").val();
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(xh))
	{
		$(".asterisk")[2].innerHTML="型号格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[2].innerHTML="";
		return true;
	}
}
function checkChejia()
{
	var cj = $("#chejiax").val();
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(cj))
	{
		$(".asterisk")[3].innerHTML="车架格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[3].innerHTML="";
		return true;
	}
}
function checkFadong()
{
	var fd = $("#fadongx").val();
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(fd))
	{
		$(".asterisk")[4].innerHTML="发动机格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[4].innerHTML="";
		return true;
	}
}
function checkColor()
{
	var co = $("#colorx").val();	
	var reg=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	if(reg.test(co))
	{
		$(".asterisk")[5].innerHTML="颜色格式不正确！";
		return false;
	}
	else
	{
		$(".asterisk")[5].innerHTML="";
		return true;
	}
}


//add car
function saveCar(s,cid,devno,pinpai,xinghao,buydt,chepai,chejia,fadong,color,tip,warn)
{
	$(".asterisk").each(function(){
		this.innerHTML="";
	});
	$(".asterisk")[0].innerHTML="*";
	//
	//init
	$("#is_show_devno")[0].style.display="none";
	$("#istipchk")[0].checked=false;
	$("#iswarnchk")[0].checked=false;
	//
	var tit;
	if(s==0)
	{
		tit="添加车辆";
		$("#is_show_devno")[0].style.display="none";
	}
	else
	{
		tit="修改车辆信息";
		$("#is_show_devno")[0].style.display="block";
		//send ajax request get deviceno
		$.ajax({
			cache:false,
			async:false,
			type:"post",
			data:{cid:cid},
			url:"getEnableDevno.action",
			success: function(data) {
				devStr = data;
				//console.log("devStr:"+devStr);
			}
		});
	}
	//
	$("#cidx").val(cid);
	$("#o").val(devno);
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

function saveCarBtn(roleid)
{
	
	if(!checkDevno()) return false;
	if(!checkChepai())	return false;
	//		
	if(!checkPinpai()) return false;
	if(!checkXinghao()) return false;
	if(!checkChejia()) return false;
	if(!checkFadong()) return false;
	if(!checkColor()) return false;
	//
	$("#form2").ajaxSubmit({ 
		success:function(data){ //提交成功的回调函数
			console.log("data:"+data);
			if(data=="成功")
			{
				//alert("保存成功");
				document.getElementById("pageflag_query").value =document.getElementById("pageflag_update").value;
				document.form1.submit();
			}
			else
			{
				alert(data);
			}
        }
	});
    return false;
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
	var pg = $("#page_car_g").val();
	$("#pageflag_query").val(pg);
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
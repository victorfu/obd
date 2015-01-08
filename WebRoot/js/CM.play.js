//play music
function play(ip,t,w)
{
	$.layer({
		type: 1,
        title: "正在播放:"+t,
        offset: [($(window).height() - 290)/2+'px', ''],
        border : [0, 0.5, '#666'],
        area: ['400px','45px'],
        shadeClose: false,
		bgcolor: '#9DA7B0',
		page:{dom:'#popMusicDiv'}
	});
	var info = "<embed src='"+ip+"/"+w+"' hidden='no' height='45' width='400' palette='red|white'></embed>";
	$("#popMusicDiv")[0].innerHTML=info;
}

$(function () {
	$(".dtree").height($(window).height());
	$(".dtree h2").click(function(){
		/*if($(this).hasClass("up")){
			$(this).siblings("ol").slideUp("fast").removeClass("up");
		}else{
			$(this).siblings("ol").slideDown('fast').addClass("up");
		}*/
		if($(this).hasClass("up")){
			$(this).siblings("ol").slideUp("fast");
			$(this).removeClass("up");
		}else{
			$(".dtree ol").slideUp("fast");
			$(".dtree h2").removeClass("up");
			$(this).siblings("ol").slideDown('fast');
			$(this).addClass("up");
		}
	});
	$(".dtree li").on('click','a', function() {
		$(".dtree li a.up").removeClass("up");
		$(this).addClass("up");
		//$(this).attr("href","javascript:void(0)");
		//var thisHref = $(this).attr(href);
	});
});	
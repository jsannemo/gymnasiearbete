$(document).ready(function(){
	$(".panel-toggle").click(function(){
		var parent = $(this).attr("data-parent");
		var body = $(parent).children(".panel-body");
		body.slideToggle({duration: 400});
		return false;
	});
});
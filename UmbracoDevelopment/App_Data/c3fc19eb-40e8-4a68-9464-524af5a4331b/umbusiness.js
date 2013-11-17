$(function() {

	$("table.sm_calendar td").hover( function () {
		$(this).children("div.events_today").fadeIn("fast");
		}, 
		function () {
		$(this).children("div.events_today").fadeOut("fast");
		}
	);

});
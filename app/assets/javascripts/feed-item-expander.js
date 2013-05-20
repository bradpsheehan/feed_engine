var add_to_order= function(){
	var item = $(this).text();
	$(order).append(new_order_item(item));
};

var remove_from_order = function(event) {
	event.preventDefault();
	$(this).remove();
}

var new_order_item = function(item) {
	var item_tag = "<li>"+item+" <a href='#' class='remove'>remove</a></li>";
	return item_tag
}

var show_text = function() {
	$(this).text = "Expand";
}

var hide_text = function() {
	$(this).text = "Collapse";
}

var toggle_feed_item_details = function() {
		alert('hey!!');

	$(".feed-details").after("<div class='feed-expander'>Expand</div>");
	$(".feed-details").toggle();
}

var toggle_summary_on_click = function() {
	$(this).prev().toggle(200);
	if(this.innerHTML == "Collapse")
		this.innerHTML = "Expand";
	else
		this.innerHTML = "Collapse";
}

var switch_active_tab = function() {
	$("ul.feeds li a").removeClass("active");
	$(this).addClass("active");
}

$(document).ready(function() {
	toggle_feed_item_details();
	$("ul.feeds li a").on("click", switch_active_tab);
	$(".sub-menu").on("click", "li", add_to_order);
	$("#order").on("click", "li", remove_from_order);
	$(".feed-expander").on("click", toggle_summary_on_click);

});

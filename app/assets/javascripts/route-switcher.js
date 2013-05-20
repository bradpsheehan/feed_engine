var toggle_feed_item_details = function() {
}

$(document).ready(function() {
    $('#new-route').toggle();

    $('input:radio[name=routeSelector]').change(function() {
        $('#existing-routes').toggle();
        $('#new-route').toggle();
    });
});

$(document).ready(function() {
    $('#new-route').toggle();

    $('input:radio[name=routeSelector]').change(function() {
        $('#run_route_id').toggle();
        $('#new-route').toggle();
    });
});

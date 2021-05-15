$(document).ready(function() {

    $(".change").on("click", function() {
        console.log("change dark mode");
        //call the Ajax to server
        $.ajax({
            url: '/set_dark_mode',
            dataType: 'json',
            type: 'POST',
            success: function(response){
                console.log(response.dark_mode);
                var dark_mode = response.dark_mode;
                set_dark_mode(dark_mode);
            },
            error: function(error){
                console.log(error);
            }
        });

    });

});
function set_dark_mode(dark_mode){
    if (dark_mode == "dark_mode") {
       $( "body, .container, .formwrapper, .btn" ).addClass( "dark" );
        $( ".change" ).text( "ON" );
    } else {
        $( "body, .container, .formwrapper, .btn" ).removeClass( "dark" );
        $( ".change" ).text( "OFF" );
    }
}

window.onload = function () {
    $(document).on("click", "#submit", function (event) {
        event.preventDefault();

        alert("Launching external email client to submit feedback!");
    })
}

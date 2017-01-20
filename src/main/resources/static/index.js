// Default value for minutes, if none is given by the user
var defaultMinutes = 30;


/*
    Check for localStorage variable to determine if user has allready started the countdown
*/
var started = localStorage.getItem('started');

/*
    If already started, redirect to status page
*/
if (started) {
    location.href = "status.html";
}


/*
    When user presses the Start-button
*/
document.getElementById('start-button').onclick = function() {
    // Set start time to localStorage
    localStorage.setItem('started', true);
    localStorage.setItem('startTime', Date.now());

    // Get the time input (in minutes)
    var minutes = document.getElementById('time-input').value;

    // If no time input, default to 30 minutes
    if (minutes === "") {
        minutes = defaultMinutes;
    }

    // Save minutes and redirect to status page
    localStorage.setItem('minutes', minutes);
    location.href = "status.html";
};
// Fetch and parse startTime from localStorage
var startTime = localStorage.getItem('startTime');
startTime = new Date(parseInt(startTime));

// Fetch and parse duration from localStorage
var minutes = localStorage.getItem('minutes');
minutes = parseInt(minutes);

// Calculate endTime
var endTime = startTime.getTime() + minutes * 60000;
endTime = new Date(endTime);

document.getElementById('timeRemaining').innerHTML = minutes;


// Update time remaining every second
window.setInterval(function() {

    // Time remaining is the endtime minus current time
    var timeRemaining = endTime - new Date()
    timeRemaining = new Date(timeRemaining);

    // Timezone offset needs to be subtracted from the hours remaining
    var hoursRemaining = timeRemaining.getHours() - (new Date().getTimezoneOffset() / -60);
    var minutesRemaining = timeRemaining.getMinutes();
    var secondsRemaining = timeRemaining.getSeconds();

    /*
        Add extra zero to seconds less than 10
    */
    if (secondsRemaining < 10) {
        secondsRemaining = "0" + secondsRemaining;
    }
    document.getElementById('timeRemaining').innerHTML = hoursRemaining + ':' + minutesRemaining + ':' + secondsRemaining;
}, 1000);



document.getElementById('timeDisplay').innerHTML = startTime.toString();
document.getElementById('endTime').innerHTML = endTime.toString();




// When user clicks the cancel button, clear localStorage and redirect to index
document.getElementById('cancel-button').onclick = function() {
    localStorage.clear();
    location.href = 'index.html';
}
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
var interval = window.setInterval(function() {

    // Time remaining is the endtime minus current time
    var timeRemaining = endTime - new Date()
    timeRemaining = new Date(timeRemaining);

    // Timezone offset needs to be subtracted from the hours remaining
    var hoursRemaining = timeRemaining.getHours() - (new Date().getTimezoneOffset() / -60);
    var minutesRemaining = timeRemaining.getMinutes();
    var secondsRemaining = timeRemaining.getSeconds();

    /*
        Add extra zero to values less than 10
    */
    if (secondsRemaining < 10) {
        secondsRemaining = "0" + secondsRemaining;
    }
    if(minutesRemaining < 10){
        minutesRemaining = "0" + minutesRemaining;
    }
    if(hoursRemaining < 10){
        hoursRemaining = "0" + hoursRemaining;
    }


    document.getElementById('timeRemaining').innerHTML = hoursRemaining + ':' + minutesRemaining + ':' + secondsRemaining;

    /*
        If time has run down, close the countdown
    */
    if(secondsRemaining == 0 && minutesRemaining == 0 && hoursRemaining == 0){

        stopInterval();
    }

}, 1000);

function stopInterval(){
    /*
        Set timeRemaining as a warning and close the countdown.
    */
    document.getElementById('timeRemaining').innerHTML =  "Time has ran out, a message to your contact" +
        " person is being sent."
    clearInterval(interval);

}

document.getElementById('timeDisplay').innerHTML = startTime.toString();
document.getElementById('endTime').innerHTML = endTime.toString();




// When user clicks the cancel button, clear localStorage and redirect to index
document.getElementById('cancel-button').onclick = function() {
    localStorage.clear();
    location.href = 'index.html';
}
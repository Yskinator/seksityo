/*
 Location script used on the show meeting -page. Uses geoPosition library and updates position every two minutes
 (while the browser is on)
 */

window.onload = function() {

    /* Get meeting update time and current time as UTC */
    var updated = new Date(meeting_updated);
    updated = updated.getTime();
    var now = new Date().getTime();

    /* Fetch position using geoPosition library */
    getPosition = function () {
        if (geoPosition.init()) {
            geoPosition.getCurrentPosition(success_callback, error_callback, {enableHighAccuracy: true});
        } else {
            document.getElementById('location').innerHTML = "Device does not support location.";
        }
    }

    /* If meeting has not been updated in the last 2 minutes, or has just been created, update location */
    if (updated < (now - 120000) || meeting_updated == meeting_created){
        getPosition();
    }

    /* Fetch new position every 2 minutes */
    setInterval(getPosition, 120000);

    /* When position is successfully fetched, add link to page */
    function success_callback(p){
        //Do not break the page by trying to update it if the meeting does not exist!
        $.getJSON('http://'+window.location.host + '/meetings/exists/'+meeting_id, function(data) {
            if (!data.meeting_exists){
                return;
            }

            /* Clear any previous location links */
            var locationDiv = document.getElementById('location');
            while (locationDiv.firstChild) {
                locationDiv.removeChild(locationDiv.lastChild);
            }

            /* Append new location link */
            var mapsLink = document.createElement('a');
            mapsLink.href = "http://maps.google.com/maps?z=12&t=m&q=loc:" + p.coords.latitude + "+"+ p.coords.longitude;
            mapsLink.innerHTML = "Your current location";
            mapsLink.target = "_blank";

            locationDiv.appendChild(mapsLink);


            /* Get form from view */
            var form = document.getElementById('locationform');

            /* Get old input fields */
            var oldLatitude = document.getElementById("latitude");
            var oldLongitude = document.getElementById("longitude");

            /* Create new input fields and append them to the form */
            var latitude = document.createElement('input');
            latitude.setAttribute('type', 'hidden');
            latitude.setAttribute('name', 'meeting[latitude]');
            latitude.setAttribute('value', p.coords.latitude);
            form.replaceChild(latitude, oldLatitude);

            var longitude = document.createElement('input');
            longitude.setAttribute('type', 'hidden');
            longitude.setAttribute('name', 'meeting[longitude]');
            longitude.setAttribute('value', p.coords.longitude);
            form.replaceChild(longitude, oldLongitude);

            /* Submit form */
            form.submit();
        });
    }

    /* Display error message in case location does not work */
    function error_callback(p){
        document.getElementById('location').innerHTML = "Error: " + p.message;
    }


}

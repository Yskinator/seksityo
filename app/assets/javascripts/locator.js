/*
 Location script used on the show meeting -page. Uses geoPosition library and updates position every two minutes
 (while the browser is on)
 */

window.onload = function() {

    /* Fetch position using geoPosition library */
    getPosition = function () {
        if (geoPosition.init()) {
            geoPosition.getCurrentPosition(success_callback, error_callback, {enableHighAccuracy: true});
        } else {
            document.getElementById('location').innerHTML = "ei toimi";
        }
    }

    getPosition();

    /* Fetch new position every 2 minutes */
    setInterval(getPosition, 120000);


    /* When position is successfully fetched, add link to page */
    function success_callback(p){

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

        // TODO: send location to backend

    }

    /* Display error message in case location does not work */
    function error_callback(p){
        document.getElementById('location').innerHTML = "Error: " + p.message;
    }


}
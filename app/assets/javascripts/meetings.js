window.onload = function() {

        /* Functions for different duration selections */
        document.getElementById('select30m').onclick = function () {
            replaceHiddenInput(createNewInput(30));
            var selected = document.getElementById('select30m');
            $(selected).addClass('selected');
            removeSelected('select30m');
            setDurationInfoText(30);
            clearManualInput();
        };
        document.getElementById('select1h').onclick = function () {
            replaceHiddenInput(createNewInput(60));
            var selected = document.getElementById('select1h');
            $(selected).addClass('selected');
            removeSelected('select1h');
            setDurationInfoText(60);
            clearManualInput();
        };
        document.getElementById('select2h').onclick = function () {
            replaceHiddenInput(createNewInput(120));
            var selected = document.getElementById('select2h');
            $(selected).addClass('selected');
            removeSelected('select2h');
            setDurationInfoText(120);
            clearManualInput();
        };

        /* Creates hidden field for the duration based on manual user input */
        document.getElementById('duration-input').onkeyup = function() {
            var input = document.getElementById('duration-input');
            if ( input.value ){
                removeSelected('');
                replaceHiddenInput(createNewInput(input.value));
                setDurationInfoText(input.value);
            } else {
                select1h();
            }
        };
        select1h();
};

/* Selects the "1h" option, called on page load */
select1h = function() {
    replaceHiddenInput(createNewInput(60));
    var selected = document.getElementById('select1h');
    $(selected).addClass('selected');
    removeSelected('select1h');
    setDurationInfoText(60);
};

/* Creates a new hidden duration field with the given value */
createNewInput = function(value) {
    var input = document.createElement("INPUT");
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', 'meeting[duration]');
    input.setAttribute('value', value);
    return input;
};

/* Replaces the (possibly) existing hidden input with a new one */
replaceHiddenInput = function(newInput) {
    var durationdiv = document.getElementById('duration-value');
    while (durationdiv.hasChildNodes()) {
        durationdiv.removeChild(durationdiv.lastChild);
    }
    durationdiv.appendChild(newInput);
};

/* Clears the manual duration input, called when a new duration is selected */
clearManualInput = function(){
    document.getElementById('duration-input').value = '';
};

/* Sets the selected duration value to the info text on top of start button */
setDurationInfoText = function(value) {
    document.getElementById('duration-info').innerHTML = value;
};

/* Removes 'selected' class from every selection, except the one specified */
removeSelected = function(id) {
    if ( id !== 'select30m') {
        var tag = document.getElementById('select30m');
        if ($(tag).hasClass('selected')) {
            $(document.getElementById('select30m')).removeClass('selected');
        }
    }
    if ( id !== 'select1h') {
        var tag = document.getElementById('select1h');
        if ($(tag).hasClass('selected')) {
            $(document.getElementById('select1h')).removeClass('selected');
        }
    }
    if ( id !== 'select2h') {
        var tag = document.getElementById('select2h');
        if ($(tag).hasClass('selected')) {
            $(document.getElementById('select2h')).removeClass('selected');
        }
    }
};




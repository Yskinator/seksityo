window.onload = function() {

        /* Functions for different duration selections */
        document.getElementById('select30m').onclick = function () {
            replaceHiddenInput(createNewInput(30));
            var selected = document.getElementById('select30m');
            $(selected).addClass('selected');
            removeSelected('select30m');
            clearManualInput();
        }
        document.getElementById('select1h').onclick = function () {
            replaceHiddenInput(createNewInput(60));
            var selected = document.getElementById('select1h');
            $(selected).addClass('selected');
            removeSelected('select1h');
            clearManualInput();
        }
        document.getElementById('select2h').onclick = function () {
            replaceHiddenInput(createNewInput(120));
            var selected = document.getElementById('select2h');
            $(selected).addClass('selected');
            removeSelected('select2h');
            clearManualInput();
        }

        /* Creates hidden field for the duration based on manual user input */
        document.getElementById('duration-value').onkeyup = function() {
            var input = document.getElementById('duration-value');
            if ( input.value ){
                removeSelected('');
                replaceHiddenInput(createNewInput(input.value));
            }
        }
        select1h();
}

/* Selects the "1h" option, called on page load */
select1h = function() {
    replaceHiddenInput(createNewInput(60));
    var selected = document.getElementById('select1h');
    $(selected).addClass('selected');
    removeSelected('select1h');
}

/* Creates a new hidden duration field with the given value */
createNewInput = function(value) {
    var input = document.createElement("INPUT");
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', 'meeting[duration]');
    input.setAttribute('value', value);
    return input;
}

/* Replaces the (possibly) existing hidden input with a new one */
replaceHiddenInput = function(newInput) {
    var durationdiv = document.getElementById('duration-input');
    while (durationdiv.hasChildNodes()) {
        durationdiv.removeChild(durationdiv.lastChild);
    }
    durationdiv.appendChild(newInput);
}

/* Clears the manual duration input, called when a new duration is selected */
clearManualInput = function(){
    document.getElementById('duration-value').value = '';
}

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
}



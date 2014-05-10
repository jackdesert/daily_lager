$(document).ready(function(){
    var separator = '--'
    var notes = dataFromController['notes']
    var divs = ''
    var counter = 0
    var singleDivFromNote = function(note){
        var div = "<div class='note'>"
        if (note !== null){
            div = div.replace('note', 'note with-text')
            div += "<div class='text'>"
            //div += note.date + separator
            div += note.bodies.join(separator)
            div += "</div>"
        }else{
            div += '&nbsp;'
        }
        div += '</div>'
        return div
    }



    notes.map(function(currentNote, index, array){
        divs += singleDivFromNote(currentNote)
    })
    $('#note-container').append(divs)

})

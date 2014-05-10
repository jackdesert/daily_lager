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

    $zoomed_note = $('#zoomed-note')
    var stuffIt = function(){
        var html = $(this).find('.text').text()
        $zoomed_note.html(html)
        $zoomed_note.show()
    }
    var clearIt = function(){
        $zoomed_note.hide()
    }


    notes.map(function(currentNote, index, array){
        divs += singleDivFromNote(currentNote)
    })
    $('#note-container').append(divs)


    $('.note.with-text').on('mouseenter', stuffIt)
    $('.note.with-text').on('mouseleave', clearIt)


})

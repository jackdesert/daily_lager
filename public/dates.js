$(document).ready(function(){
    var lastDateMS = dataFromController['dateOfLastOccurrenceInMilliseconds'] //|| 1399222959653
    var series = ''
    var oddOrEven = 'odd'
    var numberOfDivs = dataFromController['series']['dep'].length
    var firstDate = true
    var setOddOrEven = function(date){
        var choices = ['even', 'odd']
        var currentIndex = choices.indexOf(oddOrEven)
        if(date.getDay() == 6){
            oddOrEven = choices[(currentIndex + 1) % 2]
        }
    }

    var dateDiv = function(date){

        var div = '',
            theBurger = '',
            topBun,
            bottomBun = "</div>\n",
            cssClasses = ['date bar']
            months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

        setOddOrEven(date)

        cssClasses.push(oddOrEven)
        topBun = "<div class='" + cssClasses.join(' ') + "'>"
        if (date.getDate() == 1){
            theBurger = "\n  <div class='month-start'>" + months[date.getMonth()] + "&nbsp;1</div>\n"
        }
        if (firstDate === true){
            firstDate = false
            theBurger = "\n  <div class='month-start'>Today</div>\n"
        }

        return topBun + theBurger + bottomBun
    }
    var allDivs = function(startDateMS){
        var millisecondsPerDay = 86400 * 1000
        var dateArgument
        var divs = ''
        var dateMS
        for (var dateOffset = 0; dateOffset < numberOfDivs; dateOffset ++){
            dateMS = startDateMS - (millisecondsPerDay * dateOffset)
            date = new Date(dateMS)
            divs = dateDiv(date) + divs
        }
        return divs
    }


    $('#date-container').append(allDivs(lastDateMS))


})

//$(document).ready(function(){
dataFromController = {}
    var lastDateMS = dataFromController['dateOfLastOccurrenceInMilliseconds'] || 1399222959653
    var series = ''
    var oddOrEven
    var numberOfDivs = 100
    var setOddOrEven = function(date){
        var choices = ['even', 'odd']
        var currentIndex = choices.indexOf(oddOrEven)
        var absCurrentIndex = Math.abs(currentIndex)
        if(date.getDay() == 6){
            oddOrEven = choices[(absCurrentIndex + 1) % 2]
        }
    }

    var dateDiv = function(date){

        var div = '',
            theBurger = '',
            topBun,
            bottomBun = "</div>\n",
            cssClasses = ['date']
            months = ['Jan', 'Feb', 'Mar', 'Apr', 'Jun', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

        setOddOrEven(date)

        cssClasses.push(oddOrEven)
        topBun = "<div class='" + cssClasses.join(' ') + "'>"
        if (date.getDate() == 1){
            theBurger = months[date.getMonth()] + ' 1'
        }
        return topBun + theBurger + bottomBun
    }
    var allDivs = function(startDateMS){
        var millisecondsPerDay = 86400 * 1000
        var dateArgument
        var divs = ''
        var dateMS
        for (var dateOffset = 0; dateOffset <= numberOfDivs; dateOffset ++){
            dateMS = startDateMS - (millisecondsPerDay * dateOffset)
            date = new Date(dateMS)
            divs += dateDiv(date)
        }
        return divs
    }


    console.log( output = allDivs(lastDateMS) )


//})

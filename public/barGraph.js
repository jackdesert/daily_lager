$(document).ready(function(){
    var connectLink = function(keyArray){
        var keys = keyArray
        var index = 0

        var currentSeriesID = function(){
            return keys[index]
        }

        var incrementIndex = function(){
            index += 1
            if (index == keys.length){
                index = 0
            }
        }

        var hideAll = function(){
            keys.map(function(currentKey, index, array){
                $('#series_' + currentKey).hide()
            })
        }

        var showCurrent = function(){
            $('#series_' + currentSeriesID()).show()
        }

        $('#cycle').on('click', function(){
            incrementIndex()
            hideAll()
            showCurrent()
        })

        hideAll()
        showCurrent()
    }

    var displaySeries = function(label, series, parentDiv, alignTop, colorOverride){
        var divsFromSeries, seriesLabel, seriesWrapper, clear

        if (typeof colorOverride === 'undefined'){
            colorString = 'red'
        }else{
            colorString = colorOverride
        }

        divsFromSeries = function(dataArray){
            var backgroundColor,
                divs = '',
                maxValue = Math.max.apply(Math, dataArray),
                fullHeight = 20.0

            dataArray.map(function(currentValue, index, array){
                var style
                var bottomOffset = 0
                var normalizedHeight = fullHeight * currentValue / maxValue
                if (alignTop === true){
                    bottomOffset = fullHeight - normalizedHeight
                }

                if (currentValue === 0){
                    backgroundColor = 'black'
                }else{
                    backgroundColor = colorString
                }
                style = "height: " + normalizedHeight + "mm; background-color: " + backgroundColor + "; bottom: " + bottomOffset + "mm;"
                divs += "<div class='data-point' style='" + style + "' />\n"
            })
            return divs
        }

        seriesLabel = "<div class='series-label'>" + label + "</div>"
        seriesWrapper = "<div class='series-wrapper' id='series_" + label + "'>" + seriesLabel + divsFromSeries(series) + "</div>"
        clear = "<div class='clear'></div>"
        parentDiv.append(seriesWrapper)
        parentDiv.append(clear)
    }

    var mainKey = 'dep'
    var keys = Object.keys(dataFromController).sort()
    var indexOfMain = keys.indexOf(mainKey)
    keys.splice(indexOfMain, 1)

    displaySeries(mainKey, dataFromController[mainKey], $('#graphs'))

    keys.map(function(currentValue, index, array){
        thingName = currentValue
        thingSeries = dataFromController[thingName]
        displaySeries(thingName, thingSeries, $('#graphs'), true, 'blue')
    })

    connectLink(keys)

})

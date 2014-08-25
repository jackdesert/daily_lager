var angular_app = angular.module('messages', [])
  .controller('MessageCtrl', function($scope, $http){
    var outgoing = 'outgoing'
    var incoming = 'incoming'
    var log = function(something){
      console.log(something)
    }

    var historyMessage = function(text, klass){
      return  {
                klass: klass,
                text: text
              }
    }

    var data = {
                  savedHistory: [],
                  newMessage: '',

                  postMessage: function(){
                    log('in postMessage')
                    data.sendMessageToServer()
                    data.shoveNewMessageIntoHistory()
                  },

                  shoveServerResponseIntoHistory: function(response_text){
                    var newHistoryMessage = historyMessage(response_text, incoming)
                    log('in shoveServerResponseIntoHistory')
                    data.savedHistory.push(newHistoryMessage)
                  },

                  shoveNewMessageIntoHistory: function(){
                    var newHistoryMessage = historyMessage(data.newMessage, outgoing)
                    log('in shoveNewMessageIntoHistory')

                    data.savedHistory.push(newHistoryMessage)
                    data.newMessage = ''
                  },

                  sendMessageToServer: function(){
                    var url = 'messages'
                    var params = { Body: data.newMessage, secret: data.secret }
                    var config = null
                    log(params)
                    $http.post(url, params, config).success(function(response_text){
                      data.shoveServerResponseIntoHistory(response_text)
                    })
                  }
    }


    $scope.data = data

  })

// This autofocus method was given on
// http://stackoverflow.com/questions/14833326/how-to-set-focus-on-input-field-in-angularjs
angular_app.directive('autoFocus', function($timeout) {
  return {
    restrict: 'AC',
    link: function(_scope, _element)  {
                                        $timeout(function(){
                                          _element[0].focus();
                                        }, 0);
    }
  }
})
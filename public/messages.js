var app = angular.module('messages', [])
  .controller('MessageCtrl', function($scope){
    var log = function(something){
      console.log($scope.data)
      console.log(something)
    }

    var data = {
                  savedHistory: [],
                  newMessage: '',

                  postMessage: function(){
                    log('in postMessage')
                    data.shoveNewMessageIntoHistory()
                    data.sendMessageToServer()
                  },

                  shoveNewMessageIntoHistory: function(){
                    log('in shoveNewMessageIntoHistory')
                    data.savedHistory.push(data.newMessage)
                    data.newMessage = ''
                  },

                  sendMessageToServer: function(){
                    log('in sendMessageToServer')
                  }
    }


    $scope.data = data

  })

// This autofocus method was given on
// http://stackoverflow.com/questions/14833326/how-to-set-focus-on-input-field-in-angularjs
app.directive('autoFocus', function($timeout) {
  return {
    restrict: 'AC',
    link: function(_scope, _element)  {
                                        $timeout(function(){
                                          _element[0].focus();
                                        }, 0);
    }
  }
})

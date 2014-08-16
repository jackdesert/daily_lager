angular.module('messages', [])
  .controller('MessageCtrl', function($scope){
    $scope.data = { newMessage: '' ,
                    history: function(){ return 'typety type'},
                    postMessage: function(){ alert('hi') }
                  }
  })


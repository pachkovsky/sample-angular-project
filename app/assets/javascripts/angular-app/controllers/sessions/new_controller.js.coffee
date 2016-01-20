Toptal.controller 'SessionsNewController', ['$scope', '$location', 'Session', ($scope, $location, Session) ->
  $scope.ready = true
  $scope.session = {}

  $scope.sign_in = ->
    Session.save session: $scope.session, (data) ->
      localStorage.setItem('token', data.token)
      $scope.loadProfile()
      $location.path('/')
    , (data) ->
      $scope.auth_error = true
]
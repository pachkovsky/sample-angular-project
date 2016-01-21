Toptal.controller 'RegistrationsNewController', ['$scope', '$location', 'Registration', 'Session', ($scope, $location, Registration, Session) ->
  $scope.registration = {}

  $scope.sign_up = ->
    $scope.busy = true
    Registration.save registration: $scope.registration, (data) ->
      Session.save session: $scope.registration, (data) ->
        localStorage.setItem('token', data.token)
        $scope.loadProfile()
        $location.path('/')
    , (response) ->
      $scope.errors = response.data.errors
      $scope.busy = false
]
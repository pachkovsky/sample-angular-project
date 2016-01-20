Toptal.controller 'ApplicationController', ['$scope', '$location', 'Profile', 'Session', ($scope, $location, Profile, Session) ->
  $scope.loadProfile = () ->
    Profile.get (data) ->
      $scope.token = localStorage.getItem('token')
      $scope.current_user = data

  $scope.sign_out = () ->
    Session.delete ->
      $scope.current_user = null
      localStorage.removeItem('token')
      $location.path('/sessions/new')

  if localStorage.getItem('token')
    $scope.loadProfile()

  $scope.nothing = () ->
]
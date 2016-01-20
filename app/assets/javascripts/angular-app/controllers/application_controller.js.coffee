Toptal.controller 'ApplicationController', ['$scope', '$location', 'Profile', 'Session', ($scope, $location, Profile, Session) ->
  $scope.current_user = localStorage.getItem('current_user')
  $scope.role_options = [{label: 'Regular', value: 'regular'}, {label: 'Manager', value: 'manager'}, {label: 'Admin', value: 'admin'}]

  $scope.loadProfile = () ->
    Profile.get (data) ->
      $scope.token = localStorage.getItem('token')
      $scope.current_user = data
      localStorage.setItem('current_user', $scope.current_user)

  $scope.sign_out = () ->
    Session.delete ->
      $scope.current_user = null
      localStorage.removeItem('token')
      localStorage.removeItem('current_user')
      $location.path('/sessions/new')

  if localStorage.getItem('token')
    $scope.loadProfile()

  $scope.nothing = () ->
]
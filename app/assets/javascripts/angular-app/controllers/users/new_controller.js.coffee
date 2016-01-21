Toptal.controller 'UsersNewController', ['$scope', '$location', 'User', ($scope, $location, User) ->
  $scope.user = {role: 'regular'}

  $scope.save = ->
    $scope.busy = true
    User.save user: $scope.user, (data) ->
      $location.path('/users')
    , (response) ->
      $scope.errors = response.data.errors
      $scope.busy = false

  $scope.disabled = ->
    !$scope.new_user_form.$valid || $scope.busy
]
Toptal.controller 'UsersNewController', ['$scope', '$location', 'User', ($scope, $location, User) ->
  $scope.user = {role: 'regular'}

  $scope.save = ->
    User.save user: $scope.user, (data) ->
      $location.path('/users')
    , (response) ->
      $scope.errors = response.data.errors
]
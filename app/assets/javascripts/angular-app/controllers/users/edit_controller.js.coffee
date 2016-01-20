Toptal.controller 'UsersEditController', ['$scope', '$location', '$routeParams', 'User', ($scope, $location, $routeParams, User) ->
  $scope.load = ->
    User.get id: $routeParams.id, (data) ->
      $scope.user = data

  $scope.save = ->
    User.update {id: $scope.user.id}, {user: $scope.user}, (data) ->
      $location.path('/users')
    , (response) ->
      $scope.errors = response.data.errors

  $scope.load()
]
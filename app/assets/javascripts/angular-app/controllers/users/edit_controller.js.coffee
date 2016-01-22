Toptal.controller 'UsersEditController', ['$scope', '$location', '$routeParams', '$filter', 'User', ($scope, $location, $routeParams, $filter, User) ->
  $scope.load = ->
    User.get id: $routeParams.id, (data) ->
      $scope.user = data
      User.query (data) ->
        $scope.users = $filter('filter') data, (data) ->
          data.id != $scope.user.id

  $scope.save = ->
    $scope.busy = true
    User.update {id: $scope.user.id}, {user: $scope.user}, (data) ->
      $location.path('/users')
    , (response) ->
      $scope.errors = response.data.errors
      $scope.busy = false

  $scope.disabled = ->
    !$scope.edit_user_form.$valid || $scope.busy

  $scope.load()
]
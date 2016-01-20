Toptal.controller 'UsersShowController', ['$scope', '$location', 'User', ($scope, $location, User) ->
  $scope.destroy = ->
    if confirm("Are you sure?")
      User.delete {id: $scope.user.id}, ->
        $scope.load()
]
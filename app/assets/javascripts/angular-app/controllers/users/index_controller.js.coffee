Toptal.controller 'UsersIndexController', ['$scope', '$location', 'User', ($scope, $location, User) ->
  $scope.load = ->
    User.query (data) ->
      $scope.users = data

  $scope.load()
]
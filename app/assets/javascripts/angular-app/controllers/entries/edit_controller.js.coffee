Toptal.controller 'EntriesEditController', ['$scope', '$location', '$routeParams', 'Entry', 'User', ($scope, $location, $routeParams, Entry, User) ->
  $scope.load = ->
    Entry.get id: $routeParams.id, (data) ->
      $scope.entry = data
    User.query (data) ->
      $scope.users = (data)
      if $scope.current_user.role == 'manager'
        $scope.users.unshift($scope.current_user)

  $scope.save = ->
    $scope.busy = true
    Entry.update {id: $scope.entry.id}, {entry: $scope.entry}, (data) ->
      $location.path('/')
    , (response) ->
      $scope.busy = false
      $scope.errors = response.data.errors

  $scope.disabled = ->
    !$scope.edit_entry_form.$valid || $scope.busy

  $scope.load()
]
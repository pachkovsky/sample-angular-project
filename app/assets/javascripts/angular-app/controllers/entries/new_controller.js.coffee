Toptal.controller 'EntriesNewController', ['$scope', '$location', 'Entry', 'User', ($scope, $location, Entry, User) ->
  $scope.entry = {user_id: $scope.current_user.id}

  $scope.loadUsers = ->
    User.query (data) ->
      $scope.users = data
      if $scope.current_user.role == 'manager'
        $scope.users.unshift($scope.current_user)

  $scope.save = ->
    $scope.busy  = true
    Entry.save entry: $scope.entry, (data) ->
      $location.path('/')
    , (response) ->
      $scope.errors = response.data.errors
      $scope.busy   = false

  $scope.disabled = ->
    !$scope.new_entry_form.$valid || $scope.busy

  $scope.loadUsers()
]
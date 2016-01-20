Toptal.controller 'EntriesNewController', ['$scope', '$location', 'Entry', 'User', ($scope, $location, Entry, User) ->
  $scope.entry = {user_id: $scope.current_user.id}

  $scope.loadUsers = ->
    User.query (data) ->
      $scope.users = (data)

  $scope.save = ->
    Entry.save entry: $scope.entry, (data) ->
      $location.path('/')
    , (response) ->
      console.log response.data
      $scope.errors = response.data.errors

  $scope.loadUsers()
]
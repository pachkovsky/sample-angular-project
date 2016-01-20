Toptal.controller 'EntriesEditController', ['$scope', '$location', '$routeParams', 'Entry', 'User', ($scope, $location, $routeParams, Entry, User) ->
  $scope.load = ->
    Entry.get id: $routeParams.id, (data) ->
      data.date = new Date(data.date)
      $scope.entry = data
    User.query (data) ->
      $scope.users = (data)

  $scope.save = ->
    console.log($scope.entry)
    Entry.update {id: $scope.entry.id}, {entry: $scope.entry}, (data) ->
      $location.path('/')
    , (response) ->
      $scope.errors = response.data.errors

  $scope.load()
]
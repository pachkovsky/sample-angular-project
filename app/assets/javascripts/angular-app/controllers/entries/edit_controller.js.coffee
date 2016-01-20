Toptal.controller 'EntriesEditController', ['$scope', '$location', '$routeParams', 'Entry', ($scope, $location, $routeParams, Entry) ->
  $scope.load = ->
    Entry.get id: $routeParams.id, (data) ->
      data.date = new Date(data.date)
      $scope.entry = data

  $scope.save = ->
    console.log($scope.entry)
    Entry.update {id: $scope.entry._id}, {entry: $scope.entry}, (data) ->
      $location.path('/')
    , (response) ->
      $scope.errors = response.data.errors

  $scope.load()
]
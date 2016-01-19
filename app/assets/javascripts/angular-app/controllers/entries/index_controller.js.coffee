Toptal.controller 'EntriesIndexController', ['$scope', '$location', 'Entry', ($scope, $location, Entry) ->
  $scope.load = ->
    Entry.query (data) ->
      $scope.entries = data

  $scope.load()
]
Toptal.controller 'EntriesShowController', ['$scope', '$location', 'Entry', ($scope, $location, Entry) ->
  $scope.destroy = ->
    if confirm("Are you sure?")
      Entry.delete {id: $scope.entry.id}, ->
        $scope.load()
]
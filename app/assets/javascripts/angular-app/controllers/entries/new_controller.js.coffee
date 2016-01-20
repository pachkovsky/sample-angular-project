Toptal.controller 'EntriesNewController', ['$scope', '$location', 'Entry', ($scope, $location, Entry) ->
  $scope.entry = {}

  $scope.save = ->
    Entry.save entry: $scope.entry, (data) ->
      $location.path('/')
    , (response) ->
      console.log response.data
      $scope.errors = response.data.errors
]
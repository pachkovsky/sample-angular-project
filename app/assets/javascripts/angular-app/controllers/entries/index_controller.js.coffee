Toptal.controller 'EntriesIndexController', ['$scope', '$location', '$http', 'Entry', ($scope, $location, $http, Entry) ->
  $scope.days = {}
  $scope.filter_form = {}

  initFilterForm = ->
    if $location.search().from
      $scope.filter_form.from = $location.search().from
    if $location.search().to
      $scope.filter_form.to = $location.search().to

  calculateWorkingHours = ->
    $scope.days = {}
    $scope.entries.forEach (entry) ->
      $scope.days[entry.date] ||= 0
      $scope.days[entry.date] += entry.hours
    $scope.entries.forEach (entry) ->
      entry.completed = $scope.days[entry.date] >= $scope.current_user.preferred_working_hours_per_day

  $scope.filter_entries = ->
    $location.search(from: $scope.filter_form.from, to: $scope.filter_form.to)

  $scope.load = ->
    initFilterForm()
    Entry.query $scope.filter_form, (data) ->
      $scope.entries = data
      if $scope.current_user.preferred_working_hours_per_day > 0
        calculateWorkingHours()

  $scope.export = ->
    $http.get('/api/exports.html').then (response) ->
      console.log(response.data)

  $scope.load()
]
Toptal.controller 'ProfilesEditController', ['$scope', '$location', 'Profile', ($scope, $location, Profile) ->
  $scope.load = ->
    Profile.get (data) ->
      $scope.profile = data

  $scope.save = ->
    $scope.busy = true
    Profile.update profile: $scope.profile, (data) ->
      $scope.$parent.current_user = $scope.profile
      $location.path('/')
    , (response) ->
      $scope.busy = false
      $scope.errors = response.data.errors

  $scope.disabled = ->
    !$scope.edit_profile_form.$valid || $scope.busy

  $scope.load()
]
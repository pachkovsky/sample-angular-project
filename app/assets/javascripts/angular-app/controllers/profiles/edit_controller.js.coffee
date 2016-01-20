Toptal.controller 'ProfilesEditController', ['$scope', '$location', 'Profile', ($scope, $location, Profile) ->
  $scope.profile = angular.copy($scope.current_user)

  $scope.save = ->
    Profile.update profile: $scope.profile, (data) ->
      $scope.$parent.current_user = $scope.profile
      $location.path('/')
    , (response) ->
      $scope.errors = response.data.errors
]
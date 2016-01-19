@Toptal = angular.module  "Toptal",
  [
    'ngResource',
    'ngRoute',
  ]

Toptal.factory 'AuthInterceptor', ['$q', '$location', ($q, $location) ->
  request: (config) ->
    config.headers['X-Toptal-Secret'] = localStorage.getItem('token');
    config
  responseError: (response) ->
    if response.status == 401
      localStorage.removeItem('token')
      $location.path('/sessions/new')
    $q.reject(response)
]

Toptal.config ['$httpProvider', '$sceDelegateProvider', ($httpProvider, $sceDelegateProvider) ->
  $httpProvider.interceptors.push 'AuthInterceptor'
]
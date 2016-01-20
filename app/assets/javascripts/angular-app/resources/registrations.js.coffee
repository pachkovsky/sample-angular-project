Toptal.factory 'Registration', ['$resource', ($resource) ->
  $resource(
    "/api/registrations.json"
  )
]
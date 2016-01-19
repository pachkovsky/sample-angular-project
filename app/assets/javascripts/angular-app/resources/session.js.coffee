Toptal.factory 'Session', ['$resource', ($resource) ->
  $resource(
    "/api/sessions.json"
  )
]
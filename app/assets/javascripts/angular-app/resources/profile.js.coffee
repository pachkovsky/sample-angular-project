Toptal.factory 'Profile', ['$resource', ($resource) ->
  $resource(
    "/api/profiles.json"
    null
    update:
      method: 'PATCH'
  )
]
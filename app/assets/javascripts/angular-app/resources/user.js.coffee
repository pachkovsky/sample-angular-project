Toptal.factory 'User', ['$resource', ($resource) ->
  $resource(
    "/api/users/:id.json"
    null
    update:
      method: 'PATCH'
  )
]
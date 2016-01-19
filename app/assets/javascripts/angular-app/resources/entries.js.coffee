Toptal.factory 'Entry', ['$resource', ($resource) ->
  $resource(
    "/api/entries/:id.json"
    null
    update:
      method: 'PATCH'
  )
]
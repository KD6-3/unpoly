u = up.util

class up.Task extends up.Class

  constructor: ({ @onStart, @onAbort, @data }) ->
    @deferred = u.newDeferred()
    @spawnTime = new Date()
    @uid = u.uid() # TODO: Remove

  @delegate ['then', 'catch', 'finally'], 'deferred'

  abort: (message) ->
    @onAbort?(message)
    @deferred.reject(up.event.abortError(message))
    @deferred.promise()

  start: ->
    innerPromise = @onStart()
    @deferred.resolve(innerPromise)

  matches: (conditions) ->
    conditions == true ||
      conditions == this ||
      (@data && u.objectContains(@data, conditions)) ||
      (@data && conditions == @data)

  @fromAsapArgs: (args) ->
    if args[0] instanceof this
      # TaskQueue.asap(task)
      return args[0]
    else
      # TaskQueue.asap(onStart)
      onStart = u.extractCallback(args)
      return new up.Task({ onStart })

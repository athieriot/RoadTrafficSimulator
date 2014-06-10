'use strict'

define ->
  class Pool
    constructor: (@factory, pool) ->
      @objects = {}
      if pool? and pool.objects?
        for k, v of pool.objects
          @objects[k] = @factory.copy(v)

    toJSON: ->
      @objects

    get: (id) ->
      @objects[id]

    put: (obj) ->
      @objects[obj.id] = obj

    pop: (obj) ->
      id = obj.id ? obj
      result = @objects[id]
      if typeof result.release is 'function'
        result.release()
      delete @objects[id]
      result

    all: ->
      @objects

    clear: ->
      @objects = {}

    @property 'length',
      get: -> Object.keys(@objects).length
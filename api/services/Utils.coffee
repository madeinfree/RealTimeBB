Q = require 'q'

module.exports =

    promiseTask : (asyncCallback, fn) ->

        deferred = Q.defer()

        innerDeferred = Q.defer()
        innerPromise = innerDeferred.promise

        fn innerDeferred

        innerPromise.then (obj) ->

            if asyncCallback then asyncCallback null, obj else deferred.resolve obj

        , (err) ->

            if asyncCallback then asyncCallback err else deferred.reject err

        , (notifyMessage) ->

            deferred.notify notifyMessage

        deferred.promise

    isArray: (object) ->

        Array.isArray(object)

    toArray: (object) ->

        objects = null

        if not Array.isArray(object)

            objects = []
            objects.push object

        else 

            objects = object.slice()

        objects

    findSessionId: (req) ->

        sessionId = null

        if req.isSocket

            handshake = req.socket.manager.handshaken[req.socket.id]

            if handshake

                sessionId = handshake.sessionID

        else

            sessionId = req.session.id

        sessionId
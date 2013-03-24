

lp = require 'libprotocol'
{debug, error} = lp.dispatch_impl 'ILogger', 'dna-devtools'

window.addEventListener(
    "message", 
    (event) ->
        if event.source isnt window
          debug "Bad message received", event

        {action} = event.data
        switch action
            when 'collect-dna-data'
                cells = window.require('dna-lang').get_cells()
                ret = {}

                for id, cell of cells
                    ret[id] = 
                        protocols: Object.keys cell.impls
                        receptors: Object.keys cell.receptors

                r = 
                    action: action
                    result: ret

                window.postMessage r, '*'

            else
                error "Unknown action:", action

    false
)
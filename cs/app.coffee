module.exports = 
    run: ->
        bt = require 'bootstrapper'
        {dispatch_impl} = require 'libprotocol'
        {info} = dispatch_impl 'ILogger', 'App'

        bt.put_to_queue('init_queue', [
            -> info "**Starting init queue"
            -> info "**init queue done"
        ])

        bt.put_to_queue('document_ready_queue', [
            -> info "**Starting doc rdy queue"
            ->
                dna = require 'dna-lang'
                dna.start_synthesis document.body
            -> info "**doc rdy queue done"
        ])

        bt.run_init_queue()
say = (a...) -> console.log.apply console, a
lp = require 'libprotocol'
{info, warn, debug, error, notice} = lp.dispatch_impl 'ILogger', 'IDom'

IDom = [
    ['setContent',    ['new_content']]
    ['setValue',      ['new_value']]
    ['setText',       ['new_text']]
    ['getValue',      []]
    ['getValueAsync',      ['cont'], 'async']
    ['alert',         ['msg']]
    ['click',         ['handler']]
    ['keyDown',       ['handler']]
    ['say',           ['msgs']]
    ['appendContent', ['content']]
    ['kill',          []]
    ['stop_event',    ['e']]
    ['setAttr',       ['attr']]
    ['dbclick',       ['e']]
    ['focusout',      ['e']]
    ['focus',         []]
    ['get_by_attr',   ['attr']]
    ['get_by_id',     ['id']]
    ['getData',       ['attr', 'node']]
    ['get_id',        ['node']]
    ['on_dom_ready',  ['f']]
    ['one',           ['sel']]
    ['document',      []]
    ['get_root_node', []]
    ['add_event_listener', ['event_name', 'handler']]
    ['on_change',     ['f']]
    ['proxylog',      ['a']]

    ['debug',         ['a', 'b'], {vargs: true}]
]

$ = require 'commonjs-jquery'

jqidom = (node) ->
    node or= document.body
    $node = $ node

    {
        debug: debug
        
        setContent: (args...) ->
            $node.html (args.join '')

        setValue: (args...) ->
            $node.val (args.join '')

        setText: (args...) ->
            $node.text (args.join '')

        getValue: ->
            $node.val()

        getValueAsync: (cont) ->
            setTimeout(
                -> cont $node.val()
                1000
            )


        setAttr: (attr) ->
            say 'setattr'

        appendContent: (content) ->
            $node.append "<div>#{content}</div>"

        alert: (args...) ->
            alert args...

        click: (handler) ->
            $node.on 'click', handler

        say: (args...) ->
            say args...

        proxylog: (args...) ->
            say args...
            args

        kill: ->
            say 'kill'
            $node.remove()

        stop_event: (e) ->
          $.Event(e).stopPropagation()

        keyDown: (handler) ->
          $node.on 'keydown', handler

        dbclick: (handler) ->
          $node.dblclick handler

        focusout: (handler) ->
            $node.blur handler

        focus: ->
            $node.focus()

        get_by_attr: (attr) ->
            ($node.find attr).toArray()

        get_by_id: (id) -> $ "##{id}"

        getData: (attr, node=$node) -> ($ node).data()[attr]

        get_id: (node=$node) -> ($ node).attr 'id'

        on_dom_ready: (f) ->  ($ document).ready f

        one: (sel) -> ($ sel)

        document: -> window.document

        get_root_node: -> node

        add_event_listener: (event_name, handler) ->
            node.addEventListener event_name, handler

        on_change: (f) ->
            $node.change f

    }

module.exports =
    protocols:
        definitions:
            IDom: IDom
        implementations:
            IDom: jqidom

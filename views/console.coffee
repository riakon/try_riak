class Console
  promptLabel: '$ curl -X'
  # welcomeMessage: 'export BASE=http://tryriak.org/riak/'
  constructor: (selector)->
    @$el = $(selector)
    @el = @$el[0]
    @setup()

  setup: ()->
    @$el.console
      animateScroll:   true
      promptHistory:   true
      autofocus:       true
      promptLabel:     @promptLabel
      welcomeMessage:  @welcomeMessage
      commandValidate: @commandValidate
      commandHandle:   @commandHandle
      cancelHandle:    @cancelHandle

  commandValidate: (line)=>
    console.log('commandValidate')
    return line != ''

  commandHandle: (line, report, customPrompt)=>
    console.log('commandHandle')
    $.ajax '/message.json',
      headers: {'Accept': 'application/json'}
      data: { message: line }
      success: (data, textStatus, jqXHR) ->
        report([{msg: data.message, className:'jquery-console-message-value'}])

  # when ^C is pressed
  cancelHandle: (e)=>
    console.log('cancelHandle')


window.Console = Console

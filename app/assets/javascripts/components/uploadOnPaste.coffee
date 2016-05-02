@Orientation.uploader = ( options ) ->
  # settings = $.extend
  #   $element : $( '.js-accordion' )
  #   $content : $( '.js-accordion-content' )
  # , options

  defaults =
    callback: $.noop
    matchType: /image.*/

  $.fn.uploadOnPaste = (options) ->
    if typeof options == "function"
      options =
        callback: options

    options = $.extend({}, defaults, options)

    this.each ->
      element = this
      $this = $(this)

      $this.on 'dragover', (event) ->
        event.preventDefault()

      $this.on 'dragenter', (event) ->
        event.preventDefault()
        storedCss = $(this).css('border')
        $(this).css('border','1px solid greenyellow')

      $this.on 'dragleave', (event) ->
        $(this).css('border','')

      $this.on 'drop', (event) ->
        $(this).css('border','')
        event.preventDefault()

        for file, index in event.originalEvent.dataTransfer.files
          if file.type.match(options.matchType)
            reader = new FileReader()

            reader.onload = (event) ->
              options.callback.call element,
                dataURL: event.target.result
                event: event
                file: file
                name: file.name

            reader.readAsDataURL(file)

      $this.bind 'paste', (event) ->
        found = false
        clipboardData = event.originalEvent.clipboardData

        for type, index in clipboardData.types
          return if found

          if type.match(options.matchType) or clipboardData.items[index].type.match(options.matchType)
            file = clipboardData.items[index].getAsFile()

            reader = new FileReader()

            reader.onload = (event) ->
              options.callback.call element,
                dataURL: event.target.result
                event: event
                file: file
                name: file.name

            reader.readAsDataURL(file)

            found = true


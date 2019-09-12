require 'opal-jquery'
require 'opal/jquery/local_storage'
require 'text'

ACTIVE_COLOUR = '#FFDD10'
INACTIVE_COLOUR = '#DDD'

Document.ready? do

  @height = Document.height
  @width  = Document.width
  @text = Text.new

  @debug = Element.find('#debug_info')

  LocalStorage['tel'] = "07860055401" unless LocalStorage['tel']

  Element.find('#tel').value = LocalStorage['tel']
  Element.find('#pin').value = LocalStorage['pin']

  Element.find('tr').css('height', @height/16)
  Element.find('body').css('font-size', "#{@width/25}px")

  Element.find('.quick').on :click do |event|
    forward_url event.element.text
    @debug.text = @text.sms_message
  end

  Element.find("#fh#{@text.hour_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#fm#{@text.min_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#th#{@text.hour_to}").css "background-color", ACTIVE_COLOUR
  Element.find("#tm#{@text.min_to}").css "background-color", ACTIVE_COLOUR

  Element.find('.fh').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fh#{@text.hour_from}").css "background-color", INACTIVE_COLOUR
    @text.hour_from = event.element.text
    @debug.text = @text.sms_message
  end
  Element.find('.fm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fm#{@text.min_from}").css "background-color", INACTIVE_COLOUR
    @text.min_from = event.element.text
    @debug.text = @text.sms_message
  end
  Element.find('.th').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#th#{@text.hour_to}").css "background-color", INACTIVE_COLOUR
    @text.hour_to = event.element.text
    @debug.text = @text.sms_message
  end
  Element.find('.tm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#tm#{@text.min_to}").css "background-color", INACTIVE_COLOUR
    @text.min_to = event.element.text
    @debug.text = @text.sms_message
  end
  #   set_from_datepicker
  #   set_to_datepicker
  #   puts "clicked a fh!"
  #   event.element.css "background-color", ACTIVE_COLOUR
  # end

  Element.find('.book').on :click do |event|
    forward_url event.element.text
  end

  def forward_url code
    update_static_data

    tel = Element.find('#tel').value

    @text.pin_code = Element.find('#pin').value

    @text.code = code
    url = "sms:#{tel}?body=#{@text.sms_message}"

    `window.location = encodeURI(#{url})`
  end

  def update_static_data
    LocalStorage['tel'] = Element.find('#tel').value
    LocalStorage['pin'] = Element.find('#pin').value
  end

end

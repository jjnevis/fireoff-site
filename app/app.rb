require 'opal-jquery'
require 'text'
require 'settings'
require 'pin_code'

ACTIVE_COLOUR = '#FFDD10'
INACTIVE_COLOUR = '#DDD'
MINS = [":00", ":15", ":30", ":45"]

Document.ready? do

  @height = Document.height
  @width  = Document.width
  @text = Text.new

  header = Document.find('#header')
  header.text = "FireOff Web" + " (H:#{@height} W:#{@width})"

  Element.find('tr').css('height', @height/16)
  Element.find('body').css('font-size', "#{@width/25}px")

  Element.find('#offNow').on :click do |event|
    forward_url "sms:07860055401?body=52226 off 4"
  end

  Element.find('#onNow').on :click do |event|
    forward_url "sms:07860055401?body=52226 on 4"
  end

  Element.find("#fh#{@text.hour_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#fm#{@text.min_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#th#{@text.hour_to}").css "background-color", ACTIVE_COLOUR
  Element.find("#tm#{@text.min_to}").css "background-color", ACTIVE_COLOUR

  Element.find('.fh').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fh#{@text.hour_from}").css "background-color", INACTIVE_COLOUR
    @text.hour_from = event.element.text
    puts "clicked a fh!**#{event.element.text}**"
  end
  Element.find('.fm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fm#{@text.min_from}").css "background-color", INACTIVE_COLOUR
    @text.min_from = event.element.text
  end
  Element.find('.th').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#th#{@text.hour_to}").css "background-color", INACTIVE_COLOUR
    @text.hour_to = event.element.text
  end
  Element.find('.tm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#tm#{@text.min_to}").css "background-color", INACTIVE_COLOUR
    @text.min_to = event.element.text
  end
  #   set_from_datepicker
  #   set_to_datepicker
  #   puts "clicked a fh!"
  #   event.element.css "background-color", ACTIVE_COLOUR
  # end

  puts @text.hour_from
  puts @text.min_from
  puts @text.hour_to
  puts @text.min_to

  def forward_url url
    `window.location = encodeURI(#{url})`
  end

end

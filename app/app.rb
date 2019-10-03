require 'opal-jquery'
require 'opal/jquery/local_storage'

ACTIVE_COLOUR = '#FFDD10'
INACTIVE_COLOUR = '#DDD'

Document.ready? do

  @height = Document.height
  @width  = Document.width

  time = Time.now
  @time_from = time-time.sec - time.min%15*60 + 15*60 # next quarter hour

  @day_from = @time_from.day
  @hour_from = @time_from.hour
  @min_from = @time_from.min

  @time_to = @time_from+(60*60) # plus one hour

  @day_to = @time_to.day
  @hour_to = @time_to.hour
  @min_to = @time_to.min

  @debug = Element.find('#debug_info')

  Element.find('#tel').value = (LocalStorage['tel'] or "07860055401")
  Element.find('#pin').value = (LocalStorage['pin'] or "00000")

  Element.find('#tel').css('font-size', "#{@width/16}px")
  Element.find('#tel').css('width', "#{@width/2}px")
  Element.find('#pin').css('font-size', "#{@width/16}px")
  Element.find('#pin').css('width', "#{@width/5}px")

  Element.find('tr').css('height', @height/16)
  Element.find('body').css('font-size', "#{@width/25}px")

  @d_from = 0
  if @day_to == @day_from
    @d_to = 0
  else
    @d_to = 1
  end

  Element.find('#fd2').text =  (Time.now + 2*60*60*24).strftime("%A")
  Element.find('#fd3').text =  (Time.now + 3*60*60*24).strftime("%A")

  Element.find('#td2').text =  (Time.now + 2*60*60*24).strftime("%A")
  Element.find('#td3').text =  (Time.now + 3*60*60*24).strftime("%A")

  Element.find('.quick').on :click do |event|
    forward_url event.element.text
  end

  Element.find("#fd0").css "background-color", ACTIVE_COLOUR
  Element.find("#fh#{@hour_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#fm#{@min_from}").css "background-color", ACTIVE_COLOUR

  Element.find("#td0").css "background-color", ACTIVE_COLOUR
  Element.find("#th#{@hour_to}").css "background-color", ACTIVE_COLOUR
  Element.find("#tm#{@min_to}").css "background-color", ACTIVE_COLOUR

  Element.find('.fd').on :click do |event|
    Element.find("#fd#{@d_from}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @d_from = event.element.id[2].to_i
  end
  Element.find('.fh').on :click do |event|
    Element.find("#fh#{@hour_from}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @hour_from = event.element.text
  end
  Element.find('.fm').on :click do |event|
    Element.find("#fm#{@min_from}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @min_from = event.element.text
  end
  Element.find('.td').on :click do |event|
    Element.find("#td#{@d_to}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @d_to = event.element.id[2].to_i
  end
  Element.find('.th').on :click do |event|
    Element.find("#th#{@hour_to}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @hour_to = event.element.text
  end
  Element.find('.tm').on :click do |event|
    Element.find("#tm#{@min_to}").css "background-color", INACTIVE_COLOUR
    event.element.css "background-color", ACTIVE_COLOUR
    @min_to = event.element.text
  end

  Element.find('.book').on :click do |event|
    forward_url event.element.text
  end

  def forward_url code
    if (get_from > get_to)
      alert "FROM time is after TO time."
    else

      tel = LocalStorage['tel'] = Element.find('#tel').value
      pin = LocalStorage['pin'] = Element.find('#pin').value

      if ['On', 'Of'].include? code[0,2]
        url = "sms:#{tel};?&body=#{pin} #{code}"
      else
        url = "sms:#{tel};?&body=#{pin} #{sms_message} #{code}"
      end

      `window.location = encodeURI(#{url})`
    end
  end

  def sms_message
    "#{get_from.strftime("%d%m%y")} #{get_from.strftime("%H%M")} #{get_to.strftime("%d%m%y")} #{get_to.strftime("%H%M")}"
  end

  def get_from
    ft = (@time_from + (@d_from*24*60*60))
    Time.new(ft.year, ft.month, ft.day, @hour_from, @min_from)
  end

  def get_to
    ft = (@time_from + (@d_to*24*60*60))
    Time.new(ft.year, ft.month, ft.day, @hour_to, @min_to)
  end

end

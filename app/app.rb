require 'opal-jquery'
require 'text'
require 'settings'

ACTIVE_COLOUR = '#FFDD10'
INACTIVE_COLOUR = '#DDD'
# MINS = [":00", ":15", ":30", ":45"]

Document.ready? do

  @height = Document.height
  @width  = Document.width
  @text = Text.new

  @debug = Element.find('#debug_info')

  header = Document.find('#header')
  header.text = "FireOff Web" + " (H:#{@height} W:#{@width})"
  # @debug.text = @text.sanity

  Element.find('tr').css('height', @height/16)
  Element.find('body').css('font-size', "#{@width/25}px")

  Element.find('#offNow').on :click do |event|
    forward_url 'OFF'
  end

  Element.find('#onNow').on :click do |event|
    forward_url 'ON'
  end

  Element.find("#fh#{@text.hour_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#fm#{@text.min_from}").css "background-color", ACTIVE_COLOUR
  Element.find("#th#{@text.hour_to}").css "background-color", ACTIVE_COLOUR
  Element.find("#tm#{@text.min_to}").css "background-color", ACTIVE_COLOUR

  Element.find('.fh').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fh#{@text.hour_from}").css "background-color", INACTIVE_COLOUR
    @text.hour_from = event.element.text
    @debug.text = @text.sanity
  end
  Element.find('.fm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#fm#{@text.min_from}").css "background-color", INACTIVE_COLOUR
    @text.min_from = event.element.text
    @debug.text = @text.min_from
  end
  Element.find('.th').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#th#{@text.hour_to}").css "background-color", INACTIVE_COLOUR
    @text.hour_to = event.element.text
    @debug.text = event.element.text
  end
  Element.find('.tm').on :click do |event|
    event.element.css "background-color", ACTIVE_COLOUR
    Element.find("#tm#{@text.min_to}").css "background-color", INACTIVE_COLOUR
    @text.min_to = event.element.text
    @debug.text = event.element.text
  end
  #   set_from_datepicker
  #   set_to_datepicker
  #   puts "clicked a fh!"
  #   event.element.css "background-color", ACTIVE_COLOUR
  # end

  Element.find('.book').on :click do |event|
    forward_url event.element.text
  end

  # def debug text
  #   @debug.text = text
  # end

  # def send_formatted_message
  #   if Settings.setup?
  #     if @text.dates_wonky?
  #       App.alert "TO date cannot be before FROM date"
  #     else
  #       if @text.sanity?
  #         BW::UIAlertView.new({
  #           title:  @text.sanity,
  #           buttons: ['Cancel', 'OK'],
  #           cancel_button_index: 0
  #         }) do |alert|
  #           unless alert.clicked_button.cancel?
  #             send_sms
  #           end
  #         end.show
  #       else
  #         send_sms
  #       end
  #     end
  #   else
  #     App.alert "You must set up your Pin Number and SMS Number by visiting the settings page"
  #   end
  # end

  # def send_sms
  #   MFMessageComposeViewController.alloc.init.tap do |sms|
  #     sms.messageComposeDelegate = self
  #     sms.recipients = [Settings.sms_number]
  #     sms.body = @text.sms_message
  #     self.presentModalViewController(sms, animated:true)
  #   end if MFMessageComposeViewController.canSendText
  # end

  # def messageComposeViewController(controller, didFinishWithResult:result)
  #   NSLog("SMS Result: #{result}")
  #   controller.dismissModalViewControllerAnimated(true)
  #   if result == 1
  #     App.alert "Please check your messages for successfull delivery and a response message" if Settings.sms_check?
  #   end
  # end

  @debug.text = "#{@text.hour_from} #{@text.min_from} #{@text.hour_to} #{@text.min_to}"

  def forward_url code
    @text.code = code
    url = "sms:07860055401?body=#{@text.sms_message}"
    puts url

    `window.location = encodeURI(#{url})`
  end

  # def mindex(mins)
  #   {0 => 0, 15 => 1, 30 => 2, 45 => 3}[mins]
  #   mins
  # end

end

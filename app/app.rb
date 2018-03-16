require 'opal-jquery'

Document.ready? do

  @height = Document.height
  @width  = Document.width

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

  def forward_url url
    `window.location = #{url}`
  end
  # Element.find('td').on :click do |event|
  #   puts "The #{event.element.text} was clicked!"
  # end

end

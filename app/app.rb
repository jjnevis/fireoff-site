require 'opal-jquery'

Document.ready? do

  header = Document.find('#header')
  header.text = "FireOff Web"

  @height = Document.height
  @width  = Document.width
  Document.find('#info').text = "Height: #{@height}, Width: #{@width}"

  Element.find('tr').css('height', @height/16)

  Element.find('td').on :click do |event|
    puts "The #{event.element.text} was clicked!"
  end

  # Document.on :click do |evt|
  #   puts "clicked on: #{evt.current_target.name}"
  # end

end

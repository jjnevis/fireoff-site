require 'opal-jquery'

Document.ready? do

  header = Document.find('#header')
  header.text = "FireOff Web"

  @height = `$(window).height()`
  Document.find('#height').text = "Height: #{@height}"
  @width  = `$(window).width()`
  Document.find('#width').text = "Width: #{@width}"

  # `$("#width").click(function(){ $(this).hide(); });`

  Element.find('#height').on :click do
    alert "The height was clicked!"
  end

  # Document.on :click do |evt|
  #   puts "clicked on: #{evt.current_target.name}"
  # end

  puts "End of document ready"

end

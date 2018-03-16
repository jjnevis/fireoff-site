class PinCode

  attr_accessor :pin_code_data

  def pin
    '52226'
    # (@pin_code_data || Settings.pin_codes.first).split(":")[1] || (@pin_code_data || Settings.pin_codes.first).split(":")[0]
  end

  def name
    'me'
    # (@pin_code_data || Settings.pin_codes.first).split(":")[0]
  end

end

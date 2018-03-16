class Settings

  def self.sms_number
    user_defaults['sms_number']
  end
  def self.pin_codes
    user_defaults['pin_codes'] || ['Me:00000']
  end
  def self.def_hours
    user_defaults['def_hours'] || "1"
  end
  def self.web_user
    user_defaults['web_user'] || ""
  end
  def self.web_pass
    user_defaults['web_pass'] || ""
  end
  def self.web_url
    user_defaults['web_url'] || ""
  end
  def self.cust_code
    user_defaults['cust_code'] || 'T'
  end
  def self.sanity_check
    user_defaults['sanity_check'].nil? ? true : user_defaults['sanity_check']
  end
  def self.sms_check
    user_defaults['sms_check'].nil? ? true : user_defaults['sms_check']
  end
  def self.sms_number=(string)
    user_defaults['sms_number'] = string
  end
  def self.web_user=(string)
    user_defaults['web_user'] = string
  end
  def self.web_pass=(string)
    user_defaults['web_pass'] = string
  end
  def self.web_url=(string)
    user_defaults['web_url'] = string
  end
  def self.cust_code=(string)
    user_defaults['cust_code'] = string
  end
  def self.pin_codes=(codes)
    user_defaults['pin_codes'] = codes
  end
  def self.def_hours=(string)
    # only allow less than 24 hrs and quarter hours
    user_defaults['def_hours'] =
      if string.to_f > 24
        "24"
      else
        ((string.to_f*4).round / 4.0).to_s
      end
  end
  def self.sanity_check=(string)
    user_defaults['sanity_check'] = string
  end
  def self.sms_check=(string)
    user_defaults['sms_check'] = string
  end
  def self.user_defaults
    @defaults ||= {}
  end
  def self.setup?
    (pin_codes.length > 0) && sms_number && (pin_codes[0] != 'Me:00000')
  end
  def self.fsiweb_setup?
    !web_user.empty? && !web_pass.empty? && !web_url.empty?
  end
  def self.sanity?
    sanity_check
  end
  def self.sms_check?
    sms_check
  end
end

module Result
  module Success extend self
    def create data
      { result: 'success', data: data }
    end
  end

  module Failure extend self
    ERROR_MESSAGES = {
      ## common errors   ##
      10001 => 'URL not found.',
      ## service errors  ##
      # sessions #
      20101 => 'Invalid phone number.',
      20102 => 'Invalid captcha code.',
      20103 => 'Unknow phone number, it never request a captcha code.',
      20104 => 'Incorrect captcha code.',
      20105 => 'Expired captcha code.',
      # users #
      20201 => ''
    }

    def create code
      { result: 'failure', code: code, message: ERROR_MESSAGES[code] }
    end
  end
end
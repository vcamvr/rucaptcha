module RuCaptcha
  class CaptchaController < ActionController::Base
    def index
      return head :ok if request.head?
      headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
      headers['Pragma'] = 'no-cache'
      captcha_key = SecureRandom.uuid
      headers['X-CAPTCHA-KEY'] = captcha_key
      cookies[:captcha_key] = captcha_key
      data = generate_rucaptcha
      opts = { disposition: 'inline', type: 'image/gif' }
      send_data data, opts
    end
  end
end

require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  # attr_reader :cookie

  def initialize(req)
    if req.cookies.has_key?('_rails_lite_app')
      cookie_val = req.cookies['_rails_lite_app']
      @cookie = JSON.parse(cookie_val)
    else
      @cookie = {}
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app', {path: '/', value: @cookie.to_json})
  end
end

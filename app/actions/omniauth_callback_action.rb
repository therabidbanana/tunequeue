class OmniauthCallbackAction < Cramp::Action
  def respond_with
    request.session['oa-provider'] = p = request.env['omniauth.auth']['provider']
    request.session['oa-uid'] = request.env['omniauth.auth']['uid']
    request.session['oa-uid'] = request.env['omniauth.auth']['user_info']['nickname'] if p == 'twitter'
    halt(301, {'Location' => '/'}, "Authorized")
  end
end




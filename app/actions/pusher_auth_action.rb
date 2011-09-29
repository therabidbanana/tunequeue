class PusherAuthAction < Cramp::Action
  def start
    response = Pusher['presence-room'].authenticate(params[:socket_id],
                                                    {:user_id => request.session['oa-uid']})
    render response.to_json
    finish
  end
end



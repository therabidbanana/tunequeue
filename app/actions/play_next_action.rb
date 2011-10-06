class PlayNextAction < Cramp::Action
  def start
    if params.has_key?(:request_song)
      Queue.add_song(params[:request_song])
    end
    render Queue.play_next.to_json
    finish
  end

  def respond_with
    content_type = 'application/json'
    [200, {'Content-Type' => content_type}]
  end
  
end




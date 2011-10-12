class PlayQueueAction < Cramp::Action
  def start
    if params.has_key?(:request_song)
      Queue.add_song(params[:request_song])
    end
    if params.has_key?(:play_song)
      if(Queue.play_next.has_key? "song_list")
        if(Queue.play_next["song_list"].include?(params[:play_song]))
          Queue.play_song(params[:play_song])
          Pusher['presence-room'].trigger('play-song', {:url => params[:play_song]})
        end
      end
    end
    render Queue.play_next.to_json
    finish
  end

  def respond_with
    content_type = 'application/json'
    [200, {'Content-Type' => content_type}]
  end
  
end




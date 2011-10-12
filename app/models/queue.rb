class Queue
  class << self
    def play_next
      @coll ||= Tunequeue::Application.mongo['tunequeue.play_next']
      unless @play_next = @coll.find_one() #  first doc in  collection
        @play_next = {"song_list" => []} 
        @coll.insert(@play_next)
      end
      @play_next
    end
    
    def save!
      @coll.update({}, @play_next)
    end

    def add_song(url)
      @list = play_next
      @coll.update({"_id" => @list["_id"]}, {"$push" => {"song_list"=>url}})
    end

    def play_song(url)
      @list = play_next
      @coll.update({"_id" => @list["_id"]}, {"$pull" => {"song_list"=>url}})
    end

  end
end


class Settings
  class << self
    def settings
      @coll ||= Tunequeue::Application.mongo['tunequeue.settings']
      unless @settings = @coll.find_one() # settings is first doc in settings collection
        @settings = {"guest_list" => []} 
        @coll.insert(@settings)
      end
      @settings
    end
    
    def save!
      @coll.update({}, @settings)
    end

    def guest_list_includes?(provider, uid)
      puts settings.inspect + " => my settings"
      settings["guest_list"].any?{|i| i["provider"] == provider && i["uid"] == uid} 
    end
    
    def guest_list=(list)
      list = list.map do |i|
        if i =~ /@(.+)/
          {"provider" => "twitter", "uid" => $1}
        end
      end
      settings["guest_list"] = list.compact.uniq
      save!
    end
  end
end

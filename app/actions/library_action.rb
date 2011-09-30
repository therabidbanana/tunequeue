class LibraryAction < Cramp::Action
  def start
    filelist = {:tracks => Library.songs.map{|i| {:filename => i.key, :url => i.url(:expires_in => 60*60*24*30)}}}.to_json
    render filelist
    finish
  end
end


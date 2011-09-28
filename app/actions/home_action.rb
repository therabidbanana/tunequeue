class HomeAction < Cramp::Action
  def start
    render File.read(File.join(Tunequeue::Application.root(:public), 'index.html'))
    finish
  end
end


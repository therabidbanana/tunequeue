class LibraryAction < Cramp::Action
  def start
    hydra = Tunequeue::Application.hydra
    my_reqeust = Typhoeus::Request.new("http://tunequeue.s3.amazonaws.com/")
    my_reqeust.on_complete do |response|
      my_data =  Crack::XML.parse(response.body)
      render ({"tracks" => (my_data["ListBucketResult"]["Contents"].map{|i| i["Key"]})}.to_json)
      finish
    end
    hydra.queue my_reqeust
    hydra.run
  end
end


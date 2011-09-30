class Library < AWS::S3::Bucket

  def self.songs
    self.objects(Tunequeue::Application.config['s3']['bucket']).select{|s| s.content_type =~ /mp3/ || s.content_type =~ /mpeg/}
  end

end

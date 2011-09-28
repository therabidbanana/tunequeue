task :environment do
  require './application'
  Tunequeue::Application.initialize!
end

BUNDLES     = %w( application.css application.js )
namespace :assets do
  desc "Compile all the assets"
  task :precompile => :environment do
    sprockets = Tunequeue::Application.assets
    root = Tunequeue::Application.root(:public)
    BUNDLES.each do |bundle|
      assets = sprockets.find_asset(bundle)
      prefix, basename = assets.pathname.to_s.split('/')[-2..-1]
      FileUtils.mkpath File.join(root, 'assets')

      assets.write_to(File.join(root, 'assets', basename))
      assets.to_a.each do |asset|
        # strip filename.css.foo.bar.css multiple extensions
        realname = asset.pathname.basename.to_s.split(".")[0..1].join(".")
        asset.write_to(File.join(root, 'assets', realname))
      end
    end
  end

  desc "Remove compiled assets"
  task :clean => :environment do
    `rm -rf #{File.join(Tunequeue::Application.root(:public), 'assets')}`
  end
end


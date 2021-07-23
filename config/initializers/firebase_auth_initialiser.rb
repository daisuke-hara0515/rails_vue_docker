FirebaseIdToken.configure do |config|
    config.redis = Redis.new
    config.project_ids = ['https-vuejs-bef60']
end

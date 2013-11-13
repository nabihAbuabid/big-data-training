Dir["#{Rails.root}/lib/avro_logger/*.rb"].each do |f|
  require f
end
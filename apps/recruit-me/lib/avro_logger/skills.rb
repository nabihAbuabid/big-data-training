require 'avro'

module AvroLogger

  class Skills

    SCHEMA = <<-JSON
      {
        "type": "record",
        "name": "skill",
        "fields" : [
          {"name": "keyword", "type": "string"},
          {"name": "timestamp", "type": "int"}
        ]
      }
    JSON

    class << self

      def log(skills)
        schema = Avro::Schema.parse(SCHEMA)
        writer = Avro::IO::DatumWriter.new(schema)
        file = File.open(Rails.root.join('log/avro/skills.avr'), 'wb')
        dw = Avro::DataFile::Writer.new(file, writer, schema)
        skills.each do |skill|
          dw << skill
        end
        dw.close
      end

    end
  end

end
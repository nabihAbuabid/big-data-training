class Position
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  include Tire::Model::Search
  include Tire::Model::Callbacks

  field :company,     type: String
  field :position,    type: String
  field :location,    type: String
  field :skills,      type: Array

  settings :analysis => {
    :filter => {
      :ngram_filter  => {
        "type"     => "edgeNGram",
        "max_gram" => 40,
        "min_gram" => 2
      }
    },
    :analyzer => {
      :ngram_analyzer => {
        "type" => "custom",
        "tokenizer" => "standard",
        "filter" => [ "standard", "lowercase", "ngram_filter" ]
      },
      :search_analyzer => {
        "type" => "custom",
        "tokenizer" => "standard",
        "filter" => [ "standard", "lowercase"]
      },
    }
  }

  mapping do
    indexes :id,              index: :not_analyzed
    indexes :company,         analyzer: 'snowball'
    indexes :skills,          type: 'string', analyzer: 'keyword'
    indexes :updated_at,      type: 'date'
    indexes :location,        type: 'multi_field', fields: {
      location: { type: "string"},
      :"location.autocomplete" => { search_analyzer: "search_analyzer", index_analyzer: "ngram_analyzer", type: "string"}
    }
  end

end

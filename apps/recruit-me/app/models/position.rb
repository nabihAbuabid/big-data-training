class Position
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :company,     type: String
  field :position,    type: String
  field :location,    type: String
  field :skills,      type: Array

end

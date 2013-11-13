class Employment
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name,              type: String
  field :started_at,        type: Date
  field :finished_at,       type: Date
  field :position,          type: String
  field :job_description,   type: String

  embedded_in :user
end

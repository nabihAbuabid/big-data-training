class PopularSearch < Ohm::Model
  include Ohm::Expire

  attribute :name
  attribute :value
  counter :views

  index :name
  index :value

  expire 3600 # One Hour

  def to_json
    {name: name, value: value, views: views}
  end
end

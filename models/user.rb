class User
  include Mongoid::Document

  field :username
  field :first_name
  field :last_name
end

class Package < ActiveRecord::Base
  validates :name, uniqueness: { scope: :version }
end

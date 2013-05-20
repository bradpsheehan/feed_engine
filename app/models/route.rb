class Route < ActiveRecord::Base
  serialize :path
  has_many :runs
  attr_accessible :name, :path

  validates_presence_of :name, :path

  def path_points
    JSON.parse(path).collect do |hash|
      h = {}

      hash.each do |(key, value) |
        h[key.to_sym] = value
      end

      h
    end
  end
end

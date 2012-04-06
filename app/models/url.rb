class Url < ActiveRecord::Base

  validates :url, :presence => true

  #  URLs must start with http:// or https://
  validates_format_of :url, :with => URI::regexp(%w(http https))

end

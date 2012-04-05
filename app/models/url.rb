class Url < ActiveRecord::Base

  validates :url, :presence => true
  validates :short_url, :presence => true

  #  make use of ActiveModel validation
  #  URLs must start with http:// or https://

  validates_format_of :url, :with => URI::regexp(%w(http https))

end

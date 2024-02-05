class MovieFacade

  attr_reader :search_param

  def initialize(search_param = nil)
    @search_param = search_param
  end

  def self.format_runtime(minutes)# US-3 (move to facade or PORO)
    hours = minutes / 60
    remainder = minutes % 60
    "#{hours}hr #{remainder}min"
  end
end

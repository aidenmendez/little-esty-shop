class Contributor
  attr_reader :username, :commit_count, :id
  
  def initialize(data)
    @username = data[:login]
    @commit_count = data[:contributions]
    @id = data[:id]
  end
end
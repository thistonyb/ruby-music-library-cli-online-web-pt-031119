class Genre
  attr_accessor :name, :songs
  attr_reader
  @@all = []

  def initialize(name)
    @name = name
    @songs =
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Genre.new(name)
    artist.save
    return artist
  end
end

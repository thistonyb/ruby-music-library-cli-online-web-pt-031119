class Song
  attr_accessor :name,
  attr_reader :genre, :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    #@artist = artist
    self.artist = artist if artist
    #@genre = genre
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if genre.songs.include?(self)
    genre.songs << self
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
    song = Song.new(name)
    song.save
    return song
  end
end

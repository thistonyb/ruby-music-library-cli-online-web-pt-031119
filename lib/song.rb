require 'pry'
class Song
  attr_accessor :name, :genre
  attr_reader :artist
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
    if !genre.songs.include?(self)
    genre.songs << self
    end
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

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(file)
    info = file.split(" - ")
    #info = file.split(/\s*[-\.]\s*/)
    artist = Artist.find_or_create_by_name(info[0])
    genre = Genre.find_or_create_by_name(info[2].chomp(".mp3"))
    song = Song.new(info[1], artist, genre)
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
  end
end

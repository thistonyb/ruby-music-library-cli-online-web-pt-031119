require 'pry'
class MusicLibraryController

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    user_input = nil
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      user_input = gets

      case user_input
        when 'list songs'
          list_songs
        when 'list artists'
          list_artists
        when 'list genres'
          list_genres
        when 'list artist'
          list_songs_by_artist
        when 'list genre'
          list_songs_by_genre
        when 'play song'
          play_song
        end
    end
  end

  def list_songs
    counter = 1
    Song.all.sort{|a, z| a.name <=> z.name}.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end
  end

  def list_artists
    counter = 1
    Artist.all.sort{|a, z| a.name <=> z.name}.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1
    end
  end

  def list_genres
    counter = 1
    Genre.all.sort{|a, z| a.name <=> z.name}.each do |genre|
      puts "#{counter}. #{genre.name}"
      counter += 1
    end
  end

  def list_songs_by_artist
    counter = 1
    puts "Please enter the name of an artist:"
    user_input = gets
    if artist = Artist.find_by_name(user_input)
      artist.songs.sort{|a, z| a.name <=> z.name}.each do |song|
        puts "#{counter}. #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end

  def list_songs_by_genre
    counter = 1
    puts "Please enter the name of a genre:"
    user_input = gets
    if genre = Genre.find_by_name(user_input)
      genre.songs.sort{|a, z| a.name <=> z.name}.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name}"
        counter += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.to_i
    if (1..Song.all.length).include?(user_input)
      sorted_songs = Song.all.sort{|a, z| a.name <=> z.name}
     puts "Playing #{sorted_songs[user_input - 1].name} by #{sorted_songs[user_input - 1].artist.name}"
    end
  end
end

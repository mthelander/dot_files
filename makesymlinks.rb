############################
# This script creates symlinks from the home directory to any desired dot_files in ~/dot_files
############################
require 'date'
require 'io/console'

def from_home(files)
  File.join(Dir.home, files)
end

@dir       = from_home('dot_files')
@backupdir = from_home('.dot_files_old')

unless File.directory?(@backupdir)
  puts "Creating #@backupdir for backup of any existing dot files in home\n"
  Dir.mkdir(@backupdir)
end

puts "Changing to the #@dir directory."
Dir.chdir(@dir)

files = ARGV.size > 0 ? ARGV : Dir.foreach(@dir).to_a

files.each do |filename|
  next unless filename =~ /^\.\w+/
  next if filename =~ /\.sw[op]$/
  next if filename =~ /^\.git$/

  full_name, to_link = File.join(@dir, filename), from_home(filename)
  puts "Found #{full_name} to link"

  if File.symlink?(to_link)
    puts "already a symlink, skipping"
    next
  end

  puts "Create symlink to #{to_link} in home directory? [ynq]"
  response = STDIN.getch

  exit if response == 'q'

  if response == 'y'
    if File.exists?(to_link)
      puts "Found #{to_link}, moving to #@backupdir"
      File.rename(to_link, File.join(@backupdir, filename))
    end

    puts "Creating symlink..."
    File.symlink(full_name, to_link)
    puts "Done!"
  end

  puts # Extra space between files
end

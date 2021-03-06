require 'open-uri'
require 'json'

humans_txt = File.read "humans.txt" 
humans_txt = humans_txt.split /\/\* TEAM \*\//
humans_txt = humans_txt[0] + "/* TEAM */\n"

puts "querying for contributors..."
contributors = JSON.parse(open("https://api.github.com/repos/benbalter/benbalter.github.com/contributors").read)
puts "got 'em. Building..."

contributors.each do |contributor|
  humans_txt = humans_txt + "Name: " + contributor["login"] + "\nSite: " + contributor["html_url"] + "\n\n"
end

puts "Built. New Humans.txt:\n----------------------\n\n"
puts humans_txt

File.open("humans.txt", 'w') { |file| file.write humans_txt }
puts "Contributors updated."
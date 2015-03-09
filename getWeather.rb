require 'net/http'
require 'json'
require 'bigdecimal'

def request_api
  uri = URI('http://api.openweathermap.org/data/2.5/weather?q=Tokyo,jp')
  weatherData = JSON.parse(Net::HTTP.get(uri))
  currentTemp = (BigDecimal("#{weatherData["main"]["temp"]}") - BigDecimal("273.15")).to_f
  currentTemp = (BigDecimal("#{weatherData["main"]["temp"]}") - BigDecimal("273.15")).to_f
  return currentTemp
end

puts "Specify which directory to save log file.\n Default: /var/log/temperature/"
input = $stdin.gets
output_path = input.chomp
if output_path.empty?
    output_path = "/var/log/temperature/"
      puts "Output path will be #{output_path}"
end
if !File.exist?(output_path)
    `mkdir -p #{output_path}`
end

loop{
  day = Time.now
  currentTemp = request_api
  File.open("#{output_path}#{day.year}-#{day.month}-#{day.day}.log", "a") do |io|
  io.puts "#{day}\t#{currentTemp}"
  puts "#{day}\t#{currentTemp}"
  end
  sleep(60)
}

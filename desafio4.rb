require 'uri'
require 'net/http'
require 'json'

def request(url_requested)
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true 
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER 
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'
    response = http.request(request)
    return JSON.parse(response.body)
end

def build_web_page
data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=Ce6a7qOgzcpJjhLaQDLz8rY8cEujD8724UjBdDvT')
puts
html='
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<ul>
'

data["photos"].each do |i|
    html= html+ "<li><img src='#{i["img_src"]}' alt='imagen de la nasa'></li>\n"
end

html += "</ul>\n</body>\n</html>"
File.write("pagina.html", html)
end

build_web_page

def photos_count
    data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=Ce6a7qOgzcpJjhLaQDLz8rY8cEujD8724UjBdDvT')
    data["photos"].each do |i|
    fotos= "#{i["camera"]["name"]} "
    cantidad = "#{i["rover"]["total_photos"]}"
    fotosf = {"nombre" => fotos , "total de fotos" => cantidad}
    puts fotosf
    end
end
    
photos_count








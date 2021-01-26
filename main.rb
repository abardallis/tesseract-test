require 'rtesseract'

image = RTesseract.new('https://via.placeholder.com/150')
puts image.to_s

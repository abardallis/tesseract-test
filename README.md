# Tesseract Test

## Issue:
`RTesseract.new` takes the path to the image to be processed as shown:

```
image = RTesseract.new('./img.png')
puts image.to_s

=> text found in the image
```
Now let's consider the image hosted at this url: https://via.placeholder.com/150

![placeholder image](https://via.placeholder.com/150)

When ran locally, RTesseract appears to be able to take the URL as an image path.
```
image = RTesseract.new('https://via.placeholder.com/150')
puts image.to_s

=> 150x 150
```

However this does not work when ran inside a Docker container. 

### Environment
```
macOS 10.15.7
ruby 2.6.3p62
tesseract 4.1.1 (installed via Homebrew)
Docker version 20.10.2, build 2291f61

Gems:
tesseract-ocr
rtesseract
```

### Local execution (SUCCESS)
To execute locally: 

```
% brew install tesseract

% gem install bundler
% bundle install

% ruby main.rb
=> 150x 150
```

### Execution on Docker (FAILURE)
```
docker build . --tag tesseract-test --no-cache
docker run -it tesseract-test

Traceback (most recent call last):
	3: from main.rb:3:in `<main>'
	2: from /usr/lib/ruby/gems/2.6.0/gems/rtesseract-3.1.2/lib/rtesseract.rb:41:in `to_s'
	1: from /usr/lib/ruby/gems/2.6.0/gems/rtesseract-3.1.2/lib/rtesseract/text.rb:8:in `run'
/usr/lib/ruby/gems/2.6.0/gems/rtesseract-3.1.2/lib/rtesseract/command.rb:57:in `run': Error, cannot read input file https://via.placeholder.com/150: No such file or directory (RTesseract::Error)
Error during processing.
```

### Note:
When the file at the URL is downloaded and stored locally (using `OpenURI` for instance), and then the path to that file is passed to `RTesseract.new(path_to_image)` the image is successfully processed. 
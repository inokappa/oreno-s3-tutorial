FROM ruby
MAINTAINER inokappa
RUN apt-get update
RUN apt-get -y install vim
ADD . /app
RUN chmod 755 /app/upload-s3.rb
RUN gem install aws-sdk --no-ri --no-rdoc

CMD /app/upload-s3.rb

FROM ruby:3.0.0

ADD . /sinatra-docker
WORKDIR /sinatra-docker
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]

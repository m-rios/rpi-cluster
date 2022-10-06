FROM arm32v7/ruby:3.1.2-slim-buster

RUN apt update && apt install -y build-essential 

RUN gem install sinatra thin

COPY web.rb /app/

EXPOSE 4567
ENTRYPOINT ["ruby", "/app/web.rb"]

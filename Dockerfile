FROM ruby:2.6.9

RUN apt-get update
RUN apt-get install -y --allow-unauthenticated build-essential curl git nodejs apt-transport-https ca-certificates gnupg nano
RUN apt-get install -y --allow-unauthenticated zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean
ENV CONFIGURE_OPTS --disable-install-doc

WORKDIR /code

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle update

ADD . .

# RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# RUN apt-get update && apt-get install -y google-cloud-sdk
# RUN gcloud config set project e-tensor-234323

CMD rm -f tmp/pids/server.pid && bundle exec rails server

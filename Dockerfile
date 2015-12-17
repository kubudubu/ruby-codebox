FROM ubuntu:trusty
MAINTAINER "Syncano DevOps Team" <devops@syncano.com>

ENV LAST_REFRESHED 2015-12-17
ENV API_ROOT https://v4.hydraengine.com
# make sure the package repository is up to date
# install python-software-properties (so you can do add-apt-repository)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    python-software-properties \
    software-properties-common

# add brightbox's repo, for ruby2.2
RUN apt-add-repository ppa:brightbox/ruby-ng
# install ruby2.2
RUN apt-get -y update && apt-get install -y \
    ruby2.2 \
    ruby2.2-dev \
    bundler \
    javascript-common

RUN gem install rest_client \
    && gem install syncano --pre

WORKDIR /tmp
RUN chmod 1777 /tmp
# create a special user to run code
# user without root privileges greatly improves security
RUN groupadd -r syncano && useradd -r -g syncano syncano
USER syncano
CMD ["irb"]

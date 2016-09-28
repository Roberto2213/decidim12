FROM ruby:2.3.1
MAINTAINER david.morcillo@codegram

ENV APP_HOME /code

ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
ADD common_gemfile.rb /tmp/common_gemfile.rb
ADD decidim.gemspec /tmp/decidim.gemspec

ADD decidim-core/Gemfile /tmp/decidim-core/Gemfile
ADD decidim-core/Gemfile.lock /tmp/decidim-core/Gemfile.lock
ADD decidim-core/decidim-core.gemspec /tmp/decidim-core/decidim-core.gemspec
ADD decidim-core/lib/decidim/core/version.rb /tmp/decidim-core/lib/decidim/core/version.rb

ADD decidim-system/Gemfile /tmp/decidim-system/Gemfile
ADD decidim-system/Gemfile.lock /tmp/decidim-system/Gemfile.lock
ADD decidim-system/decidim-system.gemspec /tmp/decidim-system/decidim-system.gemspec

ADD decidim-admin/Gemfile /tmp/decidim-admin/Gemfile
ADD decidim-admin/Gemfile.lock /tmp/decidim-admin/Gemfile.lock
ADD decidim-admin/decidim-admin.gemspec /tmp/decidim-admin/decidim-admin.gemspec

RUN cd /tmp && bundle install

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash && \
    apt-get install -y nodejs

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

ENTRYPOINT ["bundle", "exec", "bin/decidim"]
FROM centos:7

RUN yum -y upgrade

RUN yum install -y make cpan wget tar gcc gcc-c++ zlib-devel openssl-devel expat expat-devel ncurses-devel
RUN yum install -y glibc-devel git mysql mysql-devel libxml2 libxml2-devel mysql-server gd gd-devel bzip2

RUN mkdir /downloads
RUN mkdir /usr/src/perl
WORKDIR   /usr/src/perl

RUN curl -SL https://cpan.metacpan.org/authors/id/R/RJ/RJBS/perl-5.20.0.tar.bz2 -o perl-5.20.0.tar.bz2 \
    && echo 'e925e4fc36e90eace19a1ca850f912618ba6788f *perl-5.20.0.tar.bz2' | sha1sum -c - \
    && tar --strip-components=1 -xjf perl-5.20.0.tar.bz2 -C /usr/src/perl \
    && rm perl-5.20.0.tar.bz2 \
    && ./Configure -Duse64bitall -Duseshrplib  -des \
    && make -j$(nproc) \
    && make install \
    && cd /usr/src \
    && curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
    && chmod +x cpanm \
    && ./cpanm App::cpanminus \
    && rm -fr ./cpanm /usr/src/perl /tmp/*

# Term::ReadKey does not test (seemingly because in docker build there is no terminal)
RUN cpanm --notest Term::ReadKey

RUN cpanm Module::Build
RUN cpanm --verbose --notest GD
RUN cpanm GD::SecurityImage

# Install App::Daemon dependencies (with tests)
RUN cpanm Sysadm::Install File::Pid Log::Log4perl
# App::Daemon does not test (TODO look into this)
RUN cpanm --notest App::Daemon

RUN cpanm Exception::Class Test::Harness Test::Differences Test::Exception Test::Warn Test::Deep
RUN cpanm Time::HiRes
RUN cpanm --verbose Test::Most
# RUN cpanm Business::PayPal::API
#                                                                  Business::PayPal::API
# ENV ANYEVENT_WEBSOCKET_TEST_SKIP_SSL=1 , next up also after trap 'EV'
RUN cpan MLEHMANN/AnyEvent-7.14.tar.gz
RUN cpanm Test::Most Test::Trap Beanstalk::Client Chat::Envolve Clone Config::JSON Config::YAML
RUN cpanm DateTime DateTime::Format::Duration DateTime::Format::MySQL DateTime::Format::Strptime DBD::mysql DBIx::Class
RUN cpanm DBIx::Class::DynamicSubclass DBIx::Class::InflateColumn::Serializer DBIx::Class::Schema DBIx::Class::TimeStamp
RUN cpanm Digest::HMAC_SHA1 Digest::MD5 Email::Stuff Email::Valid Facebook::Graph File::Copy File::Path Guard IO::Socket::SSL
RUN cpanm JSON JSON::Any JSON::WebToken JSON::XS List::MoreUtils List::Util
RUN cpanm List::Util::WeightedChoice Log::Any::Adapter Log::Any::Adapter::Log4perl Log::Log4perl LWP::Protocol::https LWP::UserAgent

# Fails when it cannot make a network connection
RUN cpanm --notest IO::Socket::IP
RUN cpanm Business::PayPal::API
RUN cpanm JSON::RPC::Dispatcher JSON::RPC::Dispatcher::App

# without verbose it times out and aborts due to long compilation
RUN cpanm --verbose Memcached::libmemcached Net::Server::SS::PreFork

RUN cpanm Module::Find Moose namespace::autoclean Term::ProgressBar::Simple Net::Amazon::S3 Net::Server::SS::PreFork Path::Class
RUN cpanm Plack::Middleware::CrossOrigin Pod::Simple::HTML Regexp::Common Server::Starter String::Random
RUN cpan PHRED/SOAP-Lite-1.26.tar.gz
RUN cpanm Text::CSV_XS Tie::IxHash URI::Encode UUID::Tiny XML::FeedPP XML::Hash::LX XML::Parser
RUN cpanm Term::ProgressBar Term::ProgressBar::Quiet PerlX::Maybe Firebase::Auth Gravatar::URL
RUN cpanm Digest::MD4 Bad::Words

RUN groupadd nogroup
WORKDIR /data/Lacuna-Server-Open/bin

RUN yum -y install vixie-cron
RUN chkconfig crond on

#FROM debian:10.13
FROM httpd:latest

RUN apt update
RUN apt upgrade -y

RUN 	apt-get install -y apt-transport-https lsb-release ca-certificates wget vim sed && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list && \
	apt-get update

RUN apt install -y php5.6-cli \ 
    php5.6-fpm \ 
    php5.6-bcmath \ 
    php5.6-mysql \ 
    php5.6-curl \ 
    php5.6-gd \ 
    php5.6-imagick \ 
    php5.6-intl \ 
    php5.6-mbstring \ 
    php5.6-xmlrpc \ 
    php5.6-xsl \ 
    php5.6-dev \ 
    zip php5.6-zip \ 
    php-pear \ 
    php5.6-soap \ 
    php5.6-xml \
    libapache2-mod-php5.6

RUN cp /bin/sed /usr/bin/sed
RUN pecl install timezonedb \ 
    libmcrypt-dev libreadline-dev \ 
    mcrypt \ 
    php5.6-mcrypt

RUN cat  /etc/apache2/mods-available/php5.6.load  > /usr/local/apache2/conf/php.conf && \
    cat  /etc/apache2/mods-available/php5.6.conf  >> /usr/local/apache2/conf/php.conf && \
    echo Include conf/php.conf >> /usr/local/apache2/conf/httpd.conf && \
    mkdir -p /home/www/hk-pflegedienst && ln -s  /usr/local/apache2/htdocs /home/www/hk-pflegedienst/www

# RUN sed -e 's/LoadModule\smpm_event_module/# LoadModule\ mpm_event_module/' -i /usr/local/apache2/conf/httpd.conf
# RUN sed -e 's/^#LoadModule\smpm_prefork_module/LoadModule\ mpm_prefork_module/' -i /usr/local/apache2/conf/httpd.conf
# RUN sed -e 's/^#LoadModule\srewrite_module/LoadModule\ rewrite_module/' -i /usr/local/apache2/conf/httpd.conf
# #LoadModule rewrite_module
EXPOSE 80

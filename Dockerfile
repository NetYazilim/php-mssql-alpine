FROM alpine:3.11

LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"

EXPOSE 9000

RUN apk update && apk add --no-cache curl gnupg php7 php7-pdo php7-fpm unixodbc ca-certificates && update-ca-certificates 
           
RUN cd /tmp && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.2-1_amd64.apk && \
    curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.2.1-1_amd64.apk && \
    curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.2-1_amd64.sig && \
    curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.2.1-1_amd64.sig && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --import - && \
    gpg --verify msodbcsql17_17.5.2.2-1_amd64.sig msodbcsql17_17.5.2.2-1_amd64.apk && \ 
    gpg --verify mssql-tools_17.5.2.1-1_amd64.sig mssql-tools_17.5.2.1-1_amd64.apk && \
    apk add --allow-untrusted msodbcsql17_17.5.2.2-1_amd64.apk && \
    apk add --allow-untrusted mssql-tools_17.5.2.1-1_amd64.apk && \
    curl -L https://github.com/microsoft/msphpsql/releases/download/v5.8.1/Alpine-7.3.tar | tar xv && \
    cp /tmp/Alpine-7.3/php_pdo_sqlsrv_73_nts.so /usr/lib/php7/modules/php_pdo_sqlsrv.so && \
    cp /tmp/Alpine-7.3/php_sqlsrv_73_nts.so /usr/lib/php7/modules/php_sqlsrv.so && \
    rm -r /tmp/* && \
    echo extension=php_pdo_sqlsrv > /etc/php7/conf.d/10_pdo_sqlsrv.ini && \
    echo extension=php_sqlsrv > /etc/php7/conf.d/00_sqlsrv.ini  && \
    sed -i '/^listen = /c listen = 9000' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^listen.allowed_clients/c ;listen.allowed_clients' /etc/php7/php-fpm.d/www.conf 

ENV PATH $PATH:/opt/mssql-tools/bin

CMD ["php-fpm7", "--allow-to-run-as-root", "--nodaemonize"]

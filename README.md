# PHP 7.3 & PDO_SQLSRV

This image provides an integrated development environment for PHP with connectivity to a remote SQL Server database.

[Dockerfile](https://github.com/netyazilim/php-mssql-alpine/blob/master/Dockerfile)

The following components are included:
- Alpine OS layer 3.11.
- PHP-FPM 7.3
- [sqlsrv](http://php.net/manual/en/book.sqlsrv.php) and [pdo_sqlsrv](http://php.net/manual/en/ref.pdo-sqlsrv.php) for SQL Server.
- SQL Server command-line utilities (sqlcmd and bcp).
- Installed PHP modules (php7, php7-common, php7-fpm, php7-pdo)
- [Microsoft ODBC Driver 17.5.2.2 for Linux](https://docs.microsoft.com/tr-tr/sql/connect/odbc/download-odbc-driver-for-sql-server)
- [Microsoft Drivers for PHP for SQL Server 5.8.1](https://docs.microsoft.com/en-us/sql/connect/php/download-drivers-php-sql-server)

### Config files
````
/etc/php7/php-fpm.conf
/etc/php7/php-fpm.d/www.conf
/etc/php7/php.ini
````
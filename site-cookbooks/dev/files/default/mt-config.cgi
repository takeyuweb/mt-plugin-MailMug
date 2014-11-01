## Movable Type Configuration File
##
## This file defines system-wide
## settings for Movable Type. In 
## total, there are over a hundred 
## options, but only those 
## critical for everyone are listed 
## below.
##
## Information on all others can be 
## found at:
##  http://www.movabletype.jp/documentation/config

#======== REQUIRED SETTINGS ==========

CGIPath        /cgi-bin/mt/
StaticWebPath  /mt-static/
StaticFilePath /var/www/html/mt-static

#======== DATABASE SETTINGS ==========

ObjectDriver DBI::mysql
Database movabletype
DBUser root
DBHost localhost

#======== MAIL =======================
EmailAddressMain vagrant@localhost.localdomain
MailTransfer sendmail
SendMailPath /usr/lib/sendmail
    
DefaultLanguage ja

ImageDriver ImageMagick

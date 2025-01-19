#!/bin/bash

webs(){
    KEYWORD=$1
    if [ -d /etc/nginx ];then
        echo "------nginx webs ------"
        grep -r 'server_name ' /etc/nginx/|sort|uniq
        echo ""
        if [ -n "$KEYWORD" ];then
            grep -ir "$KEYWORD" /var/log/nginx/|awk '{print $11}'|awk -F/ '{print $3}'|sort|uniq
            echo ""
        fi
    fi
    

    if [ -d /etc/apache2 ];then
        echo "------apache2 webs ------"
        grep -r -E 'ServerName |ServerAlias' /etc/apache2/|sort|uniq
        echo ""
        if [ -n "$KEYWORD" ];then
            grep -ir "$KEYWORD" /var/log/apache2/|awk '{print $11}'|awk -F/ '{print $3}'|sort|uniq
            echo ""
        fi
    fi

    if [ -d /etc/httpd ];then
        echo "------httpd webs ------"
        grep -r -E 'ServerName |ServerAlias' /etc/httpd/|sort|uniq
        echo ""
        if [ -n "$KEYWORD" ];then
            grep -ir "$KEYWORD" /var/log/httpd/|awk '{print $11}'|awk -F/ '{print $3}'|sort|uniq
            echo ""
        fi
    fi
}

webs "$1"

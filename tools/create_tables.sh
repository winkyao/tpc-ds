#!/bin/bash
mysql -u root -h 127.0.0.1 -P 4000 -e "drop database if exists tpcds"
mysql -u root -h 127.0.0.1 -P 4000 -e "create database tpcds"
mysql -h 127.0.0.1 -P 4000 -u root -Dtpcds < tpcds.sql

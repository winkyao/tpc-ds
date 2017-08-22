#!/bin/bash
mysql -u root -e "drop database if exists tpcds"
mysql -u root -e "create database tpcds"
mysql -u root -Dtpcds < tpcds.sql

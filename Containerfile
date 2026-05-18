FROM docker.io/redhat/ubi9:latest 


# ToDo: download & install the oracle-instantclient 
#
# https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
# login credentials required
#
# RUN rpm -ivh \
#   /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
#   /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm \
#   /tmp/oracle-instantclient12.2-jdbc-12.2.0.1.0-1.x86_64.rpm \
#   /tmp/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm


# ENVIRONMENT ##################################################################
# Set oracle Environment ### temporary 
ENV ORACLE_HOME='/opt/db/oracle'
ENV LD_LIBRARY_PATH="$ORACLE_HOME/lib"
# temporary faking oracle environment
RUN mkdir -p /opt/db/oracle/bin

# Set ora2pg download environment
ENV ora2pg_version="$(curl -s https://github.com/darold/ora2pg/releases/ \
  | awk '/[0-9]{4} [0-9]{2} [0-9]{2} - v[0-9]{2}\.[0-9]*/ {print $10}' \
  | sed 's.</p>$..' | awk 'NR==1')"
ENV ora2pg_download_link="https://github.com/darold/ora2pg/archive/refs/tags/${ora2pg_version}.tar.gz"


# install perl & Modules ######################################################
RUN dnf update -y \
  && dnf install -y perl

# install the DBD::Oracle Module
RUN perl -MCPAN -e 'install DBD::Oracle'

# download and Install ora2pg
# RUN wget "${ora2pg_download_link}" -O /tmp/"${ora2pg_version}.tar.gz"
RUN curl -L ${ora2pg_download_link} > /tmp/"${ora2pg_version}".tar.gz
RUN mkdir -p /opt/ora2pg_"${ora2pg_version}"
RUN tar -zxvf /tmp/"${ora2pg_version}.tar.gz" -C /opt/ora2pg_"${ora2pg_version}"

# # download and Install ora2pg
# RUN wget "${ora2pg_download_link}" -O /tmp/"${ora2pg_version}.tar.gz" \
#   && mkdir -p /opt/ora2pg_"${ora2pg_version}" \
#   && tar -zxvf /tmp/"${ora2pg_version}.tar.gz" -C /opt/ora2pg_"${ora2pg_version}"

#!/bin/bash
set -e

SOLR_HOSTNAME=`wget -qO- http://169.254.169.254/latest/meta-data/local-hostname`
HOST_PLACEMENT=`wget -qO- http://169.254.169.254/latest/meta-data/placement/availability-zone`

echo "SOLR_HOST=${SOLR_HOSTNAME}" >> /opt/solr/bin/solr.in.sh
echo "SOLR_OPTS=\"\$SOLR_OPTS -Dplacement=${HOST_PLACEMENT}\"" >> /opt/solr/bin/solr.in.sh

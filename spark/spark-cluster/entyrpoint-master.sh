#!/bin/bash

service ssh restart

/hadoop-3.2.2/sbin/start-all.sh

/spark-3.1.2/sbin/start-master.sh

bash

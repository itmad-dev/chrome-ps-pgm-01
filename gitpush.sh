#!/bin/bash
buildDate=`date +_%m%d%Y`
buildTime=`date +_%H%M`
commitString=$HOSTNAME$buildDate$buildTime
git add -A
git commit -m $commitString
git push origin


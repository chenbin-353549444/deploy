#!/bin/bash
# 测试
now=`date +%s`
function log() {
  echo "[$((`date +%s` - now ))] ## $@ ##"
}

log "Installation start at `date`"

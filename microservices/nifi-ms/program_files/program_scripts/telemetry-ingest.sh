#!/bin/bash
yarn cli ingest-grammar -g='dimension' 
yarn cli ingest-grammar -g='event' 
yarn cli ingest-dimension
yarn cli ingest-data --filter='telemetry' 

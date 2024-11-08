#!/bin/sh

cat >> src/env.js << EOF

const SERVER_URL="${SERVER_URL}:80";

export default SERVER_URL;

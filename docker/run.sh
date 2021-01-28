export NODE_PATH=dist
yarn link @biocad/jfw
yarn link bioterms
yarn link sbolgraph
sleep 10
nodemon /opt/synbiohub-lab/dist/synbiohub/main.js

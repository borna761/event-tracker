# Event Tracker — container image.
# Zero npm dependencies; needs Node 22+ for the built-in node:sqlite.
FROM node:22-alpine

WORKDIR /app

COPY package.json ./
COPY db.js server.js ./
COPY public ./public

# The SQLite database lives in /data so it can be a bind mount or volume.
# The base image's non-root "node" user (uid/gid 1000) owns it.
ENV NODE_ENV=production \
    PORT=4321 \
    DB_PATH=/data/event-tracker.db
RUN mkdir -p /data && chown node:node /data
USER node
VOLUME /data

EXPOSE 4321

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:'+process.env.PORT+'/').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", "server.js"]

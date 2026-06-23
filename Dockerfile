FROM node:20-bullseye

WORKDIR /app

# Use a writable npm cache location for non-root runs in varied environments
ENV npm_config_cache=/tmp/.npm

# Install dependencies first for better layer caching
COPY package.json package-lock.json ./
RUN npm ci

# Copy project files and run the build + artifact check
COPY . .
RUN npm run build && node test/assets.js

# Default command keeps this image useful for manual rebuilds too
CMD ["npm", "run", "build"]

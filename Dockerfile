# Creating  Node.js image
FROM node:18-alpine

# working directory
WORKDIR /app
COPY package*.json ./

# Install production dependencies
RUN npm install --production
COPY . .

# Expose the app's default port
EXPOSE 3000

# Set environment variable for the port
ENV PORT=3000

# Start the app
CMD ["npm", "start"]

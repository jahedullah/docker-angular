# Use an official Node.js image as a base . this is production build file
FROM node:18-bullseye as builder

# Set the working directory
WORKDIR '/app'


# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install Angular CLI globally (optional, if you haven't installed it globally yet)
# RUN npm install -g @angular/cli

# Install dependencies. ci means clean install
# RUN npm ci
RUN npm install -f

# Copy the rest of the application code
COPY . .

RUN npm run build --prod
# # Expose the port the app runs it does not matter. it always runs to 4200

# EXPOSE 4200

# Start the Angular development server
# CMD ["ng", "serve", "--host", "0.0.0.0"]
# CMD ["ng", "serve"]

FROM nginx:latest



COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#this is the path where my browser is.
COPY --from=builder /app/dist/test-app1/browser /usr/share/nginx/html/

EXPOSE 80

#!/usr/bin/env bash

# Navigate to the directory of your React app
cd ~/reactapps

# Pull latest changes from Git repository
git pull origin main

# Install dependencies
npm install

# Build the React app
npm run build

# Remove existing files in the document root
# sudo rm -rf /var/www/test_nixntronics/public_html/*

# Copy the built React app to the document root
sudo cp -r ~/reactapps/build/* /var/www/test_nixntronics/public_html/


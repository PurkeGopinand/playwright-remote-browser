# playwright-remote-browser

playwright-remote-browser setup on server

# Clone repos

```bash
cd ..
cd home
git clone https://github.com/PurkeGopinand/playwright-remote-browser.git
cd playwright-remote-browser

```

## Docker Setup

```bash

# Install Docker
apt update && apt upgrade -y
apt install -y docker.io
systemctl start docker
systemctl enable docker

# Install Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify the installation:
docker --version
docker-compose --version

# Clean Docker
docker ps -a
docker-compose down
docker stop playwright-browser-1
docker stop playwright-browser-2
docker stop uptime-worker
docker stop uptime-redis
docker rm playwright-browser-1
docker rm playwright-browser-2
docker rm uptime-worker
docker rm uptime-redis
docker system prune -a --volumes --force

# Ports Setup
sudo ufw status
sudo ufw allow 9222
sudo ufw allow 9223
sudo ufw enable

```

# Deploy Docker Containers

```bash

cd /home/playwright-remote-browser
git pull origin main

# Deploy with script
./deploy.sh

# Deploy with Commands
docker-compose down
docker-compose build --no-cache
docker-compose up -d
docker-compose logs -f

# Test nginx configuration
sudo nginx -t
# Reload Nginx
cd ..
cd etc/nginx/site-available
sudo systemctl reload nginx

```

# Setup HTTP Basic Authentication

```bash
# 1. Create htpasswd files for each browser

# For Browser 1 (staging-browser.uptimelead.com)
sudo htpasswd -c /etc/nginx/.htpasswd-playwright-browser-1 playwright-browser-1-admin
# For Browser 2 (dev-browser.uptimelead.com)
sudo htpasswd -c /etc/nginx/.htpasswd-playwright-browser-2 playwright-browser-2-admin

# Enter password when prompted

# Test Authentication

# Test Browser 1 (should fail without credentials)
curl -I https://playwright-browser-1.uptimelead.com/json/version
# Test Browser 1 (should succeed with credentials)
curl -I -u playwright-browser-1-admin:your-password https://playwright-browser-1.uptimelead.com/json/version
# Test Browser 2 (should fail without credentials)
curl -I https://playwright-browser-2.uptimelead.com/json/version
# Test Browser 2 (should succeed with credentials)
curl -I -u playwright-browser-2-admin:your-password https://playwright-browser-2.uptimelead.com/json/version

```

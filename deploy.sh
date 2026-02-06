set -e

echo "🚀 Deploying Remote Browsers..."

# Pull latest code
echo "📥 Pulling latest code..."
git pull

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build images
echo "🏗️ Building images..."
docker-compose build --no-cache

# Start all services
echo "🚀 Starting services..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to start..."
sleep 15

# Check status
echo "📊 Service status:"
docker-compose ps

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 Services running:"
echo "  - Playwright Browser 1: ws://localhost:9222"
echo ""
echo "📊 View logs: docker-compose logs -f"
echo "📊 Check status: docker-compose ps"

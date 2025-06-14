
# Project variables
BINARY_NAME=glancr
CMD_PATH=./cmd/server
DIST_DIR=dist
UI_DIR=ui

# Go variables
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOMOD=$(GOCMD) mod

# Build info
VERSION?=dev
BUILD_TIME=$(shell date -u '+%Y-%m-%d_%H:%M:%S')
LDFLAGS=-ldflags "-X main.Version=$(VERSION) -X main.BuildTime=$(BUILD_TIME)"

# Build tags
DEV_TAGS=
PROD_TAGS=-tags prod

.PHONY: all build build-dev build-prod build-frontend build-backend clean test deps dev help

# Default target (development build)
all: clean deps build-dev

# Help target
help:
	@echo "Available targets:"
	@echo "  all            - Clean, install deps, and build for development"
	@echo "  build-dev      - Build for development (uses filesystem assets)"
	@echo "  build-prod     - Build for production (embeds assets)"
	@echo "  build-frontend - Build frontend only"
	@echo "  build-backend  - Build backend only (development mode)"
	@echo "  build-backend-prod - Build backend with embedded assets"
	@echo "  dev            - Start development servers"
	@echo "  clean          - Clean build artifacts"
	@echo "  test           - Run Go tests"
	@echo "  deps           - Install dependencies"
	@echo "  release        - Build production release"

# Development build (default)
build-dev: build-frontend-dev build-backend-dev

# Production build
build-prod: build-frontend build-backend-prod

# Alias for backward compatibility
build: build-dev

# Build frontend for development (output to internal/fs/dist)
build-frontend-dev:
	@echo "Building frontend for development..."
	cd $(UI_DIR) && npm run build
	@echo "Copying frontend assets to internal/fs/dist..."
	rm -rf internal/fs/dist
	cp -r $(UI_DIR)/dist internal/fs/

# Build frontend for production
build-frontend:
	@echo "Building frontend for production..."
	cd $(UI_DIR) && npm run build
	@echo "Copying frontend assets to internal/fs/dist..."
	rm -rf internal/fs/dist
	cp -r $(UI_DIR)/dist internal/fs/

# Build backend for development
build-backend-dev:
	@echo "Building backend for development..."
	mkdir -p $(DIST_DIR)
	$(GOBUILD) $(DEV_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME) $(CMD_PATH)

# Build backend for production (with embedded assets)
build-backend-prod:
	@echo "Building backend for production (embedded assets)..."
	mkdir -p $(DIST_DIR)
	$(GOBUILD) $(PROD_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME) $(CMD_PATH)

# Development mode
dev:
	@echo "Starting development environment..."
	@echo "Frontend: http://localhost:5173"
	@echo "Backend: http://localhost:8080"
	@echo "Press Ctrl+C to stop both servers"
	@bash dev.sh

# Clean build artifacts
clean:
	@echo "Cleaning..."
	$(GOCLEAN)
	rm -rf $(DIST_DIR)
	rm -rf internal/fs/dist
	cd $(UI_DIR) && rm -rf dist node_modules/.vite

# Deep clean (including node_modules)
clean-all: clean
	cd $(UI_DIR) && rm -rf node_modules

# Install dependencies
deps:
	@echo "Installing Go dependencies..."
	$(GOMOD) download
	$(GOMOD) tidy
	@echo "Installing Node dependencies..."
	cd $(UI_DIR) && npm install

# Run Go tests
test:
	$(GOTEST) -v ./...

# Run Go tests with prod build tags
test-prod:
	$(GOTEST) $(PROD_TAGS) -v ./...

# Run all tests (both dev and prod)
test-all: test test-prod

# Production release build
release: clean deps build-prod
	@echo "Production build complete!"
	@echo "Binary: $(DIST_DIR)/$(BINARY_NAME)"

# Build for multiple platforms (production)
build-cross-prod: build-frontend
	@echo "Building for multiple platforms (production)..."
	mkdir -p $(DIST_DIR)
	GOOS=linux GOARCH=amd64 $(GOBUILD) $(PROD_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-linux-amd64 $(CMD_PATH)
	GOOS=darwin GOARCH=amd64 $(GOBUILD) $(PROD_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-darwin-amd64 $(CMD_PATH)
	GOOS=darwin GOARCH=arm64 $(GOBUILD) $(PROD_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-darwin-arm64 $(CMD_PATH)
	GOOS=windows GOARCH=amd64 $(GOBUILD) $(PROD_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-windows-amd64.exe $(CMD_PATH)

# Build for multiple platforms (development)
build-cross-dev: build-frontend-dev
	@echo "Building for multiple platforms (development)..."
	mkdir -p $(DIST_DIR)
	GOOS=linux GOARCH=amd64 $(GOBUILD) $(DEV_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-dev-linux-amd64 $(CMD_PATH)
	GOOS=darwin GOARCH=amd64 $(GOBUILD) $(DEV_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-dev-darwin-amd64 $(CMD_PATH)
	GOOS=darwin GOARCH=arm64 $(GOBUILD) $(DEV_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-dev-darwin-arm64 $(CMD_PATH)
	GOOS=windows GOARCH=amd64 $(GOBUILD) $(DEV_TAGS) $(LDFLAGS) -o $(DIST_DIR)/$(BINARY_NAME)-dev-windows-amd64.exe $(CMD_PATH)

# Install binary (development version)
install-dev: build-backend-dev
	$(GOCMD) install $(DEV_TAGS) $(LDFLAGS) $(CMD_PATH)

# Install binary (production version)
install-prod: build-backend-prod
	$(GOCMD) install $(PROD_TAGS) $(LDFLAGS) $(CMD_PATH)

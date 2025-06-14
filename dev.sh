#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CLEANUP_DONE=false

# Function to cleanup background processes
cleanup() {
    if [ "$CLEANUP_DONE" = true ]; then
        return
    fi
    CLEANUP_DONE=true

    echo -e "\n${YELLOW}Shutting down servers...${NC}"
    if [ ! -z "$VITE_PID" ]; then
        kill $VITE_PID 2>/dev/null
        echo -e "${GREEN}Vite dev server stopped${NC}"
    fi
    if [ ! -z "$GO_PID" ]; then
        kill $GO_PID 2>/dev/null
        echo -e "${GREEN}Go server stopped${NC}"
    fi
    exit 0
}

# Set trap to cleanup on script exit
trap cleanup SIGINT SIGTERM EXIT

echo -e "${GREEN}Starting Glancr development environment...${NC}"
echo -e "${YELLOW}Frontend will be available at: http://localhost:5173${NC}"
echo -e "${YELLOW}Backend will be available at: http://localhost:8080${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop both servers${NC}"
echo ""

# Start Vite dev server in the background
echo -e "${GREEN}Starting Vite dev server...${NC}"
cd ui
npm run dev &
VITE_PID=$!
cd ..

# Give Vite a moment to start
sleep 2

# Start Go server in the background
echo -e "${GREEN}Starting Go server...${NC}"
go run ./cmd/server &
GO_PID=$!

# Wait for both processes
wait

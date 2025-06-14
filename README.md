# glancr

A modern Markdown documentation viewer built with Go and React. **glancr** provides a clean, fast interface for browsing and viewing Markdown documentation with live reload capabilities during development.

## Features

- 🚀 **Fast & Lightweight** - Single binary deployment with embedded assets
- 📝 **Markdown Rendering** - Beautiful rendering of Markdown documents
- 🔄 **Live Development** - Hot reload during development
- 🎨 **Modern UI** - Clean, responsive React-based interface
- 📱 **Mobile Friendly** - Responsive design that works on all devices
- 🔧 **Easy Setup** - Simple development and deployment workflow

## Prerequisites

- **Go** 1.19+ 
- **Node.js** 18+ and npm
- **Git**

## Quick Start

### Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/smjklake/glancr.git
   cd glancr
   ```

2. **Install dependencies**
   ```bash
   make deps
   ```

3. **Start development servers**
   ```bash
   make dev
   ```

   This will start:
   - Frontend dev server at http://localhost:5173
   - Backend API server at http://localhost:8080

### Production Build

1. **Build for production**
   ```bash
   make build-prod
   ```

2. **Run the binary**
   ```bash
   ./dist/glancr
   ```

   The application will be available at http://localhost:8080

## Available Commands

### Development
- `make dev` - Start development environment with live reload
- `make build-dev` - Build development version (filesystem assets)
- `make test` - Run Go tests

### Production  
- `make build-prod` - Build production version (embedded assets)
- `make release` - Clean build for production release
- `make build-cross-prod` - Build for multiple platforms

### Utilities
- `make clean` - Clean build artifacts
- `make clean-all` - Deep clean including node_modules
- `make deps` - Install all dependencies
- `make help` - Show all available commands

## Project Structure

```
glancr/
├── cmd/
│   └── server/          # Application entry point
│       └── main.go
├── internal/            # Private application code
│   ├── auth/           # Authentication logic
│   └── fs/             # Asset handling (dev/prod)
├── ui/                 # React frontend
│   ├── src/
│   ├── public/
│   └── package.json
├── dist/               # Build output
├── Makefile           # Build automation
├── dev.sh             # Development script
└── go.mod             # Go module definition
```

## Architecture

**glancr** uses a clean architecture with clear separation between frontend and backend:

- **Backend (Go)**: Serves the React SPA and provides API endpoints
- **Frontend (React)**: Modern TypeScript-based UI with Vite tooling
- **Asset Handling**: Development mode serves from filesystem, production embeds assets in binary
- **Build System**: Makefile orchestrates both Go and Node.js build processes

## Development Workflow

### Adding Features

1. **Backend changes**: Add logic in `internal/` packages
2. **Frontend changes**: Modify React components in `ui/src/`
3. **API endpoints**: Update server routes in `cmd/server/main.go`

### Testing

```bash
# Run Go tests
make test

# Run with production build tags
make test-prod

# Run all tests
make test-all
```

### Code Quality

The frontend includes:
- **ESLint** for code linting
- **Prettier** for code formatting  
- **TypeScript** for type safety

```bash
cd ui
npm run lint          # Check for linting issues
npm run lint:fix      # Fix auto-fixable issues
npm run format        # Format code with Prettier
```

## Deployment

### Single Binary Deployment

Build and deploy the production binary:

```bash
make release
scp dist/glancr user@server:/path/to/deployment/
```

### Cross-Platform Builds

Generate binaries for multiple platforms:

```bash
make build-cross-prod
```

Produces:
- `glancr-linux-amd64`
- `glancr-darwin-amd64` 
- `glancr-darwin-arm64`
- `glancr-windows-amd64.exe`

## Configuration

Currently **glancr** runs with minimal configuration. The server starts on port 8080 by default.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`make test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Follow Go conventions and use `gofmt`
- Write tests for new functionality
- Use TypeScript for frontend development
- Run `make lint` before committing
- Keep commits atomic and well-described

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Go](https://golang.org/) and [React](https://reactjs.org/)
- Bundled with [Vite](https://vitejs.dev/)
- Styled with modern CSS practices

---

**glancr** - Making documentation beautiful, one markdown file at a time. ✨
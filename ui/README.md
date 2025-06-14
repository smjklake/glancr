# glancr UI

The React frontend for **glancr** - a modern Markdown documentation viewer. This UI provides a clean, responsive interface built with React 19, TypeScript, and Vite.

## Tech Stack

- **React 19** - Latest React with concurrent features
- **TypeScript** - Type-safe JavaScript development
- **Vite** - Fast build tool and dev server
- **ESLint** - Code linting and quality checks
- **Prettier** - Code formatting
- **CSS3** - Modern styling with CSS custom properties

## Prerequisites

- **Node.js** 18+ 
- **npm** (comes with Node.js)

## Quick Start

### Development

1. **Install dependencies**
   ```bash
   npm install
   ```

2. **Start development server**
   ```bash
   npm run dev
   ```
   
   The UI will be available at http://localhost:5173

3. **Start with backend** (recommended)
   ```bash
   npm run dev:full
   ```
   
   This starts both the Vite dev server and the Go backend server.

### Production Build

```bash
npm run build
```

Outputs optimized files to `dist/` directory.

## Available Scripts

### Development
- `npm run dev` - Start Vite dev server only
- `npm run dev:full` - Start both frontend and backend servers
- `npm run watch` - Build in watch mode

### Building
- `npm run build` - Production build
- `npm run preview` - Preview production build locally

### Code Quality
- `npm run lint` - Run ESLint checks
- `npm run lint:fix` - Fix auto-fixable ESLint issues
- `npm run format` - Format code with Prettier
- `npm run format:check` - Check if code is properly formatted

## Project Structure

```
ui/
├── src/
│   ├── assets/         # Static assets (images, icons, etc.)
│   ├── App.tsx         # Main application component
│   ├── App.css         # Application styles
│   ├── main.tsx        # Application entry point
│   ├── index.css       # Global styles
│   └── vite-env.d.ts   # Vite type definitions
├── public/             # Public static files
├── dist/               # Build output (generated)
├── index.html          # HTML template
├── package.json        # Dependencies and scripts
├── vite.config.ts      # Vite configuration
├── tsconfig.json       # TypeScript configuration
├── tsconfig.app.json   # App-specific TypeScript config
├── tsconfig.node.json  # Node-specific TypeScript config
├── eslint.config.ts    # ESLint configuration
└── prettier.config.ts  # Prettier configuration
```

## Development Guidelines

### Code Style

- **TypeScript**: Use strict type checking
- **Components**: Functional components with hooks
- **Naming**: PascalCase for components, camelCase for functions/variables
- **Imports**: Use absolute imports when possible

### File Organization

As the project grows, consider this structure:

```
src/
├── components/         # Reusable UI components
│   ├── common/        # Generic components
│   └── markdown/      # Markdown-specific components
├── hooks/             # Custom React hooks
├── types/             # TypeScript type definitions
├── utils/             # Utility functions
├── styles/            # CSS modules or styled components
└── api/               # API client functions
```

### Component Guidelines

- Use TypeScript interfaces for prop types
- Implement proper error boundaries
- Follow React best practices for hooks
- Use semantic HTML elements
- Ensure accessibility (ARIA labels, keyboard navigation)

Example component structure:
```typescript
interface MyComponentProps {
  title: string;
  onAction?: () => void;
}

export function MyComponent({ title, onAction }: MyComponentProps) {
  // Component logic here
  return (
    <div>
      <h2>{title}</h2>
      {/* Component JSX */}
    </div>
  );
}
```

## API Integration

The frontend communicates with the Go backend through a proxy configuration in `vite.config.ts`:

```typescript
server: {
  proxy: {
    '/api': {
      target: 'http://localhost:8080',
      changeOrigin: true,
    },
  },
}
```

This allows you to make API calls to `/api/*` endpoints during development, which will be proxied to the Go server.

## Environment Variables

Create a `.env.local` file for local environment variables:

```env
VITE_API_BASE_URL=http://localhost:8080
```

Access in code:
```typescript
const apiUrl = import.meta.env.VITE_API_BASE_URL;
```

## Testing

Currently, no testing framework is configured. Consider adding:

- **Vitest** - Fast unit testing (Vite-native)
- **Testing Library** - React component testing
- **Playwright** - End-to-end testing

## Performance Considerations

- **Code Splitting**: Use React.lazy() for route-based splitting
- **Bundle Analysis**: Use `npm run build` and analyze bundle size
- **Images**: Optimize images and use appropriate formats
- **Caching**: Leverage Vite's built-in caching strategies

## Deployment

The UI is built and embedded into the Go binary for production. The build process:

1. `npm run build` creates optimized files in `dist/`
2. The Go build process embeds these files using `//go:embed`
3. The resulting binary serves the UI as a SPA

## Browser Support

- **Modern browsers** with ES2020+ support
- **Chrome/Edge** 88+
- **Firefox** 84+
- **Safari** 14+

## Troubleshooting

### Common Issues

**Port already in use**
```bash
# Kill process using port 5173
lsof -ti:5173 | xargs kill -9
```

**Node modules issues**
```bash
# Clean install
rm -rf node_modules package-lock.json
npm install
```

**TypeScript errors**
```bash
# Check TypeScript configuration
npx tsc --noEmit
```

### Development Tips

- Use React DevTools browser extension
- Enable Vite's built-in HMR for instant updates
- Use TypeScript strict mode for better type safety
- Set up your editor with ESLint and Prettier extensions

## Contributing

When contributing to the UI:

1. Follow the established code style
2. Add TypeScript types for new components
3. Test your changes in both dev and production builds
4. Run linting and formatting before committing
5. Consider responsive design for all screen sizes

## Integration with Backend

The UI is designed to work seamlessly with the Go backend:

- **Development**: Vite proxy handles API routing
- **Production**: Served as static files by Go server
- **SPA Routing**: Backend handles client-side routing fallback

---

Part of the **glancr** project - making documentation beautiful, one component at a time. ⚛️
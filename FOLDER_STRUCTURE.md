# Vite + React Folder Structure (Feature-Based)

A scalable layout that groups code **by feature** rather than by file type. It works for small apps and keeps large ones manageable.

```
vite-test/
├── public/                     # Static files served as-is (favicon, robots.txt)
│   └── favicon.svg
│
├── src/
│   ├── main.tsx                # Entry point: renders <App />, wraps providers
│   ├── App.tsx                 # Root component: layout + router outlet
│   ├── vite-env.d.ts           # Vite type declarations
│   │
│   ├── assets/                 # Images, fonts, icons imported in code
│   │   ├── images/
│   │   └── fonts/
│   │
│   ├── components/             # Shared, reusable UI (no business logic)
│   │   ├── ui/                 # Primitives: Button, Input, Modal, Card
│   │   │   ├── Button/
│   │   │   │   ├── Button.tsx
│   │   │   │   ├── Button.module.css
│   │   │   │   ├── Button.test.tsx
│   │   │   │   └── index.ts    # export { Button } from './Button'
│   │   │   └── Modal/
│   │   └── layout/             # Header, Footer, Sidebar, PageLayout
│   │
│   ├── features/               # Self-contained feature modules
│   │   ├── auth/
│   │   │   ├── components/     # LoginForm, SignupForm
│   │   │   ├── hooks/          # useAuth
│   │   │   ├── api/            # login(), logout(), getUser()
│   │   │   ├── types.ts
│   │   │   └── index.ts        # Public API of the feature
│   │   └── todos/
│   │       ├── components/
│   │       ├── hooks/
│   │       ├── api/
│   │       ├── types.ts
│   │       └── index.ts
│   │
│   ├── pages/                  # Route-level components (thin; compose features)
│   │   ├── HomePage.tsx
│   │   ├── LoginPage.tsx
│   │   └── NotFoundPage.tsx
│   │
│   ├── routes/                 # Router config (React Router / TanStack Router)
│   │   └── index.tsx
│   │
│   ├── hooks/                  # Global, generic hooks: useDebounce, useLocalStorage
│   │
│   ├── lib/                    # Configured third-party clients
│   │   ├── axios.ts            # or fetch wrapper
│   │   └── queryClient.ts      # TanStack Query client
│   │
│   ├── services/               # Shared API calls not owned by one feature
│   │
│   ├── store/                  # Global state (Zustand / Redux / Context)
│   │
│   ├── context/                # React Context providers (Theme, Auth)
│   │
│   ├── utils/                  # Pure helper functions: formatDate, cn()
│   │
│   ├── types/                  # Global/shared TypeScript types
│   │
│   ├── constants/              # App-wide constants, enums, config values
│   │
│   └── styles/                 # Global CSS, variables, resets
│       ├── index.css
│       └── variables.css
│
├── tests/                      # E2E tests (Playwright/Cypress) + test setup
│   └── setup.ts
│
├── .env                        # VITE_* env vars (never commit secrets)
├── .env.example
├── .gitignore
├── eslint.config.js
├── index.html                  # Vite's HTML entry (lives at root, not public/)
├── package.json
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.node.json
└── vite.config.ts
```

## Key Principles

| Rule | Why |
|------|-----|
| **Group by feature**, not by type | Everything for "auth" lives together; easy to find, move, or delete |
| **`components/` = dumb & reusable** | Shared UI shouldn't know about business logic |
| **`pages/` stay thin** | Pages compose features; logic lives in `features/` |
| **Each feature exports via `index.ts`** | Other code imports `@/features/auth`, not deep internal paths |
| **Colocate tests & styles** | `Button.test.tsx` sits next to `Button.tsx` |
| **Features don't import from each other** | Prevents tangled dependencies; share via `components/`, `hooks/`, `lib/` |

## Path Alias (recommended)

Avoid `../../../` imports by adding an `@` alias.

**vite.config.ts**
```ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'node:path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: { '@': path.resolve(import.meta.dirname, './src') },
  },
})
```

**tsconfig.app.json**
```json
{
  "compilerOptions": {
    "paths": { "@/*": ["./src/*"] }
  }
}
```

Usage:
```ts
import { Button } from '@/components/ui/Button'
import { useAuth } from '@/features/auth'
```

## Small Projects

For a tiny app or interview exercise, this is enough — grow into the full structure later:

```
src/
├── main.tsx
├── App.tsx
├── components/
├── hooks/
├── pages/
├── utils/
└── styles/
```

## Creating a New App From This Boilerplate

```bash
./create-app.sh my-new-app ~/Desktop/Code    # copies template, renames, git init, npm install
cd ~/Desktop/Code/my-new-app && npm run dev
```

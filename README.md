# Vite React Template

A React + TypeScript + Vite starter with a feature-based folder structure, an `@/` import alias, and Oxlint.

## Create a new app

**With degit** (no git history, works anywhere):

```bash
npx degit johnloui17/vite-react-template my-app
cd my-app
npm install
npm run dev
```

**With the included script** (after cloning this repo once):

```bash
git clone https://github.com/johnloui17/vite-react-template.git ~/templates/vite-react-template
~/templates/vite-react-template/create-app.sh my-app ~/Desktop/Code
```

The script copies the template, renames the app, runs `git init` and `npm install`, and makes an initial commit. Add an alias to `~/.zshrc` to run it from anywhere:

```bash
alias newvite="~/templates/vite-react-template/create-app.sh"
```

## Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start the dev server |
| `npm run build` | Type-check and build for production |
| `npm run preview` | Preview the production build |
| `npm run lint` | Lint with Oxlint |

## Folder structure

See [FOLDER_STRUCTURE.md](FOLDER_STRUCTURE.md) for the full layout and conventions.

```
src/
├── assets/        # Images, fonts
├── components/    # Shared UI (ui/, layout/)
├── features/      # Feature modules (components, hooks, api, types)
├── pages/         # Route-level components
├── hooks/         # Global hooks
├── lib/           # Configured third-party clients
├── services/      # Shared API calls
├── store/         # Global state
├── context/       # React Context providers
├── utils/         # Pure helpers
├── types/         # Shared TypeScript types
├── constants/     # App-wide constants
└── styles/        # Global CSS
```

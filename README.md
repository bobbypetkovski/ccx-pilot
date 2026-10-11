# ccx-pilot

Survey recruitment pilot proposal, prepared for ConsumerCentriX.

One HTML file, no build step. Two accounts sign in, edit the same proposal,
comment, tick off next steps, tag each other and see changes live.

## Deploy

### 1. Git

```bash
cd ccx-pilot
git init
git add .
git commit -m "Pilot proposal"
git branch -M main
git remote add origin git@github.com:bobbypetkovski/ccx-pilot.git
git push -u origin main
```

If the repo already has a commit, run `git pull --rebase origin main` first.

### 2. Vercel

Import the repo at vercel.com/new. Framework preset **Other**, build command
and output directory empty. Every push to `main` redeploys.

### 3. Supabase

You can reuse the Conciergia project or create a new one.

1. Authentication → Users → Add user → Create new user. Add two users: you and
   the client. Set a password for each, keep "auto confirm" on.
2. SQL Editor → paste `supabase/schema.sql` → replace the client email → Run.
3. Project Settings → API → copy the Project URL and the publishable/anon key.

### 4. Wire it up

At the top of the `<script>` in `index.html`:

```js
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_KEY = 'sb_publishable_...';
const ACCOUNTS = {
  'm-bobby': 'bobbypetkovski@gmail.com',
  'm-ccx':   'client@consumercentrix.com',
};
```

The emails must match the Supabase users and the schema exactly. Push, and the
login screen appears.

## How it behaves

- **Before Supabase is configured** it runs locally: no login, saves to your
  browser. Use this to edit the copy before deploying.
- **Country switcher** in the header: text containing `{country}` or `{payout}`
  follows the selected country. Add countries in section 10.
- **Pilot switch**: mark it agreed and set a start date, and the timeline fills
  in real dates.
- **Export JSON** in the footer backs up the whole proposal. **Reset to
  default** restores the original text.

# Phoenix
A 32-bit OS for x86 users.

## Build the ISO (via GitHub — no local machine needed)

1. Create a new **empty** repo on GitHub (github.com → New repository — don't add a README)
2. In the Replit shell, run these commands (replace the URL with yours):
   ```bash
   cd /home/runner/workspace/phoenix-os
   git init
   git add .
   git commit -m "init"
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```
3. Go to your repo on GitHub → **Actions** tab
4. The build starts automatically — takes ~10–20 minutes
5. Click the finished run → scroll down to **Artifacts** → download **phoenix-v86-iso**

## Manual build (requires openSUSE + KIWI NG)

```bash
bash scripts/build-v86-iso.sh    # produces dist/phoenix-v86.iso
bash scripts/build-v86-disk.sh   # produces dist/phoenix-v86.img
```

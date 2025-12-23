make ssh for your git profile

```
ssh-keygen -t ed25519 -C "global@gmail.com" -f ~/.ssh/id_ed25519
ssh-keygen -t ed25519 -C "work@gmail.com" -f ~/.ssh/id_ed25519_work
ssh-keygen -t ed25519 -C "personal@gmail.com" -f ~/.ssh/id_ed25519_personal
```

```
chmod 700  ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

usually I cp global to only id_ed25519 for default user
```
; optional but if you want
cp id_ed25519_global.pub id_ed25519.pub
cp id_ed25519_global id_ed25519
```

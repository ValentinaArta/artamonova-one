# Valentina Artamonova website

Static personal website for [artamonova.one](https://artamonova.one).

## Files

- `index.html` — page and styles
- `assets/valentina-artamonova.jpg` — portrait
- `deploy.sh` — updates the VPS from this repository and copies the site into Nginx's web directory

## Hosting

- VPS: `89.167.117.180`
- Git checkout: `/root/artamonova-website`
- Nginx document root: `/var/www/artamonova.one`
- Nginx config: `/etc/nginx/sites-available/artamonova.one`
- DNS at one.com: A record for `artamonova.one`, CNAME `www` to `artamonova.one`
- HTTPS certificate managed by Certbot

After making a change in GitHub, run on the VPS as root:

```bash
bash /root/artamonova-website/deploy.sh
```

The script pulls `main` and copies the current page and photo into the live web directory. If new assets are added later, update the script to copy them too.

# Передача проекта: artamonova.one

Дата состояния: 29 сентября 2026 года.

## Результат

Сайт-визитка Валентины Артамоновой опубликован по адресу https://artamonova.one. Адрес https://www.artamonova.one перенаправляет на основной. Страница и фотография открывались в браузере; локальная проверка Nginx возвращала `200 OK`, а проверка перенаправления с www — `301` с `Location: https://artamonova.one/`.

## Исходный код и сервер

- Приватный GitHub-репозиторий: https://github.com/ValentinaArta/artamonova-one
- Основная ветка: `main`
- Файлы: `index.html`, `assets/valentina-artamonova.jpg`, `deploy.sh`, `README.md`
- VPS: Hetzner Cloud, Ubuntu 24.04, IPv4 `89.167.117.180`
- Git-копия на VPS: `/root/artamonova-website`
- Папка, которую обслуживает Nginx: `/var/www/artamonova.one`
- Конфигурация Nginx: `/etc/nginx/sites-available/artamonova.one`; включена ссылкой в `/etc/nginx/sites-enabled/`
- Веб-сервер: Nginx; сертификат Let's Encrypt установлен через Certbot с плагином Nginx.

Git-копия находится в `/root`, поэтому Nginx читает отдельную копию файлов из `/var/www/artamonova.one`. Изменение файла в GitHub само по себе не меняет опубликованный сайт.

## DNS и HTTPS

DNS управляется в one.com для домена artamonova.one:

| Тип   | Имя                               | Значение         |
|-------|-----------------------------------|------------------|
| A     | корневой домен (пустой Hostname)  | `89.167.117.180` |
| CNAME | `www`                             | `artamonova.one` |

Почтовые записи one.com не менялись. Сертификат охватывает `artamonova.one` и `www.artamonova.one`. На момент выдачи Certbot сообщил срок действия до 28 декабря 2026 года и настроенную фоновую задачу автоматического продления. HTTP переводится на HTTPS; HTTPS-запросы к www переводятся на основной домен.

## Как обновлять сайт

После изменения и сохранения файлов в ветке `main` GitHub выполнить на VPS под root:

```bash
bash /root/artamonova-website/deploy.sh
```

Скрипт делает `git pull --ff-only origin main` и копирует `index.html` и `assets/valentina-artamonova.jpg` в `/var/www/artamonova.one`. Эти файлы Nginx обслуживает без перезапуска. Если проект получит новые картинки, CSS, JavaScript или другие файлы, обновить `deploy.sh`, чтобы он копировал и их. Доступ к приватному GitHub-репозиторию на VPS был подтверждён успешным `git fetch` и `git pull` через VS Code; при будущей смене способа входа Git может запросить авторизацию повторно.

## Проверки и диагностика

```bash
nginx -t
systemctl status nginx --no-pager -l
curl -I https://artamonova.one/
curl -I https://www.artamonova.one/
dig +short artamonova.one A
dig +short www.artamonova.one
```

После правки конфигурации Nginx применять её командой `nginx -t && systemctl reload nginx`. При проблемах с сертификатом проверить `certbot certificates` и журнал `/var/log/letsencrypt/letsencrypt.log`.

## Контекст для следующего агента

Пользователь предпочитает вести настройку на русском, по одному небольшому шагу с проверкой результата. Она работает в VS Code, подключённом к VPS, и может выполнять команды в удалённом терминале. Не просить присылать пароль, токены или приватные ключи. Для изменений сайта использовать указанный GitHub-репозиторий, затем запускать развёртывание на VPS. Не путать этот VPS с ранее созданным предварительным размещением сайта в ChatGPT Sites.

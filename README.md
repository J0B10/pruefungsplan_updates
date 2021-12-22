# Prüfungsplan Updates
Dieses Bash Skript überprüft, ob ein neuer Prüfungsplan verfügbar ist und postet ihn ggf. im Discord Channel (via Webhook). 

### Setup

Einfach das Skript in Reglmäßigen Abständen (z.B. Stündlich) auf einem Server ausführen. 

Zunächst muss allerdings ein [Discord Webhook](https://support.discord.com/hc/de/articles/228383668-Einleitung-in-Webhooks) angelegt werden.  

Dann muss die Webhook URL als Umgebungsvariable `WEBHOOK_URL` auf dem Server gesetzt werden:

```shell
export WEBHOOK_URL=https://example.webhook.url/
```

Am Besten gleich zur .bashrc hinzufügen!

Beispielkonfiguration crontab:
```
0 * * * * export WEBHOOK_URL=https://example.webhook.url/; bash pruefungsplan_updates.bash
```
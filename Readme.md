# [sakura.nna774.net](sakura.nna774.net)

## 注意

kagoyaなら、インスタンス作ってから、

```
apt-get install debian-archive-keyring
apt-get update
```

しないと走りません。

rootで

```
passwd
```

しておくと吉(しとかないとsudoできないよ)。

## つかいかた

### Apply

```
rake apply:sakura.nna774.net REMOTE_USER=nona
```

apply calls dry-run and requires confirmation before applying.

### Dry-run

```
rake dryrun:sakura.nna774.net REMOTE_USER=nona
```

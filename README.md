# DNS Changer (for Iranian developers)

![](/screenshots/usage.gif)

## Installation

```zsh
git clone https://github.com/aliizadi00dev/dns-changer
cd dns-changer
sudo cp ./dns_changer.sh /usr/local/bin/dns_changer
```

- Creating Auto Startup Entry:

```zsh
cp ./dnschanger.desktop ~/.config/autostart/
```

## Usage

After installation run this program as background process and add it to startup applications to check your DNS every one minute and notify you to make decision for you that you need it at now or not.

- Notification showed at top-right of screen in most distro and looks like this:
  ![](/screenshots/notification.png)

- For running first use this:

```zsh
dns_changer &
```

> You should add this command to startup application or see installation section for creating `.desktop` entry to `~/.config/autostart` (for some desktop environment this method not work).

1. Check if you already connected to DNS server:

```zsh
dnsstatus
```

2. Use [403.online](https://403.online/) DNS:

```zsh
up403
```

3. Use [Bogzar](https://begzar.ir/) DNS:

```zsh
upbogzar
```

4. Use [Shecan](https://shecan.ir/) DNS:

```zsh
upshecan
```

5. If you don't need DNS, down it by this command:

```zsh
downdns
```

## Powered By

[https://403.online/](https://403.online/)  
[https://shecan.ir/](https://shecan.ir/)  
[https://begzar.ir/](https://begzar.ir/)

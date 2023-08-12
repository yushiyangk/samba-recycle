# samba-recycle

Clean up old recycled files in a Samba share

## Install

1. Install `samba-recycle` from this repository to `/opt/samba-recycle/`

2. Set permissions

	```bash
	sudo chown -R root: /opt/samba-recycle
	sudo chmod a+rx,o-w /opt/samba-recycle/samba-recycle
	```

	All users will be able to execute `samba-recycle`, but they will still only be able to delete files for which they have write permissions.

3. [Add `/opt/samba-recycle` to `PATH`](#add-optsamba-recycle-or-optbin-to-sudo-path) (or add `/opt/bin` to `PATH` and add symlink `ln -s /opt/samba-recycle/samba-recycle /opt/bin/samba-recycle`)

### Configure

Create config file at `/etc/opt/samba-recycle.conf` containing

<code><pre>recycle_age=<var>recycle_age</var></pre></code>

Files that were last modified <code><var>recycle_age</var></code> number of days ago will be removed.

Set permission of the config file:

```bash
sudo chown root: /etc/opt/samba-recycle.conf
sudo chmod o-w /etc/opt/samba-recycle.conf
```

## Run

```bash
samba-recycle
```

Or run <code>samba-recycle <var>recycle_age</var></code> to override the configured value.

### Run schedule

To clean up old recycled files at regular intervals, run `sudo crontab -e` and add the following
<code><pre>00 <var>hour</var> * * * /opt/samba-recycle/samba-recycle</pre></code>

This runs `samba-recycle` every day at <code><var>hour</var></code> o'clock.

## Troubleshooting

### Add `/opt/samba-recycle` or `/opt/bin` to sudo `PATH`

The correct place to set the `PATH` environment variable varies by distribution. For Debian, add a new file to `/etc/profiles.d/` containing

<pre><code>PATH="<var>additional_paths</var>:$PATH"</code></pre>

However, this may not work for sudo commands. In that case, run

```bash
sudo visudo
```

and edit the `Defaults secure_path` value.

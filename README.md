## WP Dockerfile for local development

Numerous improvements over my original version, updated in 2026 to use ClassicPress instead. 

it's all the same, but for the "database host" step in the initial setup, just use `db` instead of `localhost`

Just create a blank `wp_data` directory, run `docker-compose up -d` or `podman compose up -d` if you're one of the cool kids,
`chown -R user:user` the directories you need to work on. This should probably only be used for development as-is.
Also the makefile is really for other projects, but it's a nice reference for commands, despite not working for this project.

### notes, as an aside

if you ever find yourself needing to create an admin user on an existing prod wp site, create your user in the db as usual, then elevate permissions with these queries, subbing your ID for "X"
```
-- For wp_capabilities
INSERT INTO wp_usermeta (user_id, meta_key, meta_value)
VALUES (X, 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}')
ON DUPLICATE KEY UPDATE meta_value = 'a:1:{s:13:"administrator";b:1;}';

-- For wp_user_level
INSERT INTO wp_usermeta (user_id, meta_key, meta_value)
VALUES (X, 'wp_user_level', '10')
ON DUPLICATE KEY UPDATE meta_value = '10';
```

Another useful thing, you can pipe file contents over ssh if tools like scp, or inconsistent pathing proves an obstacle (looking at you, clownways)
```
ssh master_username@xxx.xxx.xxx.xxx cat /home/master/applications/random_clownways_name/public_html/dump.sql > dump.sql
```

OR, for a directory:
```
ssh master_username@xxx.xxx.xxx.xxx tar -czf - /home/master/applications/clownways_name/public_html/wp-content | tar -xzf - -C .
```

FOR VOID LINUX
---------------------------------

there are other instructions in the jobsplugin repo, but make sure that you set your .config/containers/registries.conf file like so:
```
#[registries.search]
#unqualified-search-registries = ["docker.io"]
unqualified-search-registries = ["docker.io", "quay.io"]

[[registry]]
location = "docker.io"

```
You may also need to install aardvarkdns and netavark. 

Your updated registries.conf should resemble this:
```
# Use the V2 format explicitly
unqualified-search-registries = ["docker.io", "quay.io"]

[[registry]]
location = "docker.io"

[[registry]]
location = "quay.io"

[network]
network_backend = "netavark"
```

Finally, you may need to manually load the requisite kernel modules. ```sudo momdprobe ip_tables```. Now the containers should build.

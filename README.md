## WP Dockerfile for local development

Numerous improvements over my original version. 

Just create a blank `wp_data` directory, run `docker-compose up -d`,
`chown -R user:user` the directories you need to work on. This should probably only be used for development as-is.


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

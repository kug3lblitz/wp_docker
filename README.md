## WP Dockerfile for local development

Numerous improvements over my original version. 

Just create a blank `wp_data` directory, run `docker-compose up -d`,
`chown -R user:user` the directories you need to work on. This should probably only be used for development as-is.

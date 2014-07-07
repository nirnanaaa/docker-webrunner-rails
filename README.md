# Docker container for running a Rails /w Puma application

Example Rails project can be found at [[https://github.com/nirnanaaa/floriankasper]]

## `start <git:optional>` Run an application

This allows an application to start. The shell script executes the following
rake tasks on startup:

* `db:migrate`
* `assets:precompile`

using the Rails environment `production`. 

`db:migrate` only gets executed if a `config/database.yml` file is
present.

`assets:precompile` gets executed unless the environment variable
`PRECOMPILE` is set to false

### `config/hooks/pre_start`
This hook gets executed right before the start of puma. This must be a
ruby script.

### `config/additional_packages.yml`
This installs additional packages onto the system, necessary for
building some ruby c extensions.

Example layout:

```yaml
install:
  - "libicu-dev"
  - "libssl-dev"
  - "node"
  - ...
```

### Example asset sync config

```bash
export AWS_ACCESS_KEY_ID=xxxx
export AWS_SECRET_ACCESS_KEY=xxxx
export FOG_DIRECTORY=xxxx

heroku config:add FOG_REGION=eu-west-1
heroku config:add ASSET_SYNC_GZIP_COMPRESSION=true
heroku config:add ASSET_SYNC_MANIFEST=true
heroku config:add ASSET_SYNC_EXISTING_REMOTE_FILES=keep
```

# ODP-Admin-Deploy

Docker-based deployment of the [ODP Admin](https://github.com/SAEONData/ODP-Admin) service.

## Installation

Create a `.env` file in the project directory on the target machine, and set the following environment variables:

- **`FLASK_ENV`**: deployment environment: `development`|`testing`|`staging`|`production`
- **`FLASK_SECRET_KEY`**: Flask [SECRET_KEY](https://flask.palletsprojects.com/en/1.1.x/config/#SECRET_KEY)
- **`DATABASE_URL`**: ODP accounts database URL
- **`HYDRA_PUBLIC_URL`**: URL of the Hydra public API
- **`HYDRA_ADMIN_URL`**: URL of the Hydra admin API
- **`OAUTH2_CLIENT_SECRET`**: client secret for the admin service UI, as registered in Hydra

_N.B. Make sure to generate cryptographically strong secrets for `FLASK_SECRET_KEY` and `OAUTH2_CLIENT_SECRET`,
and to back these up securely._

Start the admin service container in the background:

    sudo docker-compose up -d

Initialize the ODP accounts database:

    sudo docker exec odp-admin flask initdb

## Upgrading

In the project directory on the target machine, run:

    git pull

Update the `.env` file as necessary, then run:

    sudo docker-compose down
    sudo docker-compose build --no-cache
    sudo docker-compose up -d

## Notes

### Upgrading dependencies

To upgrade dependencies and re-generate the `requirements.txt` file for a new release,
carry out the following steps:

1. Activate the Admin Service virtual environment.
1. Upgrade Python libraries as necessary.
1. Ensure that unit tests for the Admin Service and project dependencies all pass.
1. Run the following command:
`pip freeze | sed -E '/^(-e\s|pkg-resources==)/d' > requirements.txt`

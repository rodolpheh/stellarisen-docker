# :whale: Stellarisen Docker

Docker builds and configurations for [:sparkles: Stellarisen](https://github.com/rodolpheh/stellarisen).

- [:package: Getting the sources](#package-getting-the-sources)
- [:wrench: Configuration](#wrench-configuration)
- [:building_construction: Deployment](#buildingconstruction-deployment)

## :package: Getting the sources

Clone the repository, initialize the submodule and update it :

```bash
git clone https://github.com/rodolpheh/stellarisen-docker
cd stellarisen-docker
git submodule init
git submodule update
```

## :wrench: Configuration

Before deploying the website, edit the [`docker-compose.yml`](./docker-compose.yml) to change the configuration of the database. Most of the environment variables are located in the first part of the file. The last important one is the `MYSQL_ROOT_PASSWORD` in the configuration of the `db` service.

## :building_construction: Deployment

```bash
docker-compose up
```

On first launch, it will take some time to build the images, download the dependencies for the back-end, and set up the database.

After that, you should be able to access the website through the port 80 of your host.

SSL/TLS is not included.
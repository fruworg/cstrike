# cstrike
Образ основан на [этом репозитории](https://github.com/AMXX4u/BasePack).

## setup
```
mkdir /opt/cstrike
cd /opt/cstrike
git clone github.com/fruworg/cstrike .
docker compose up -d
```

## build
```
mkdir /opt/cstrike
cd /opt/cstrike
git clone github.com/fruworg/cstrike .
docker build . --platform=linux/386 -t cstrike
```

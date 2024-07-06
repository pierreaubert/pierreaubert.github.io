# monitoring

Note that prometheus, grafana, mimir etc are running on the spin machine.
```
sudo apt install prometheus-node-exporter prometheus-blackbox-exporter prometheus-ipmi-exporter
```
In order to monitor the nvidia GPUs: look into this project. Currently running on the admin machines and not on horn.
```
cd ~/src
git clone https://github.com/utkuozdemir/nvidia_gpu_exporter.git
cd nvidia_gpu_exporter/cmd/nvidia_gpu_exporter
go build
sudo cp nvidia_gpu_exporter /usr/sbin/
cd ../../../systemd
sudo cp nvidia_gpu_exporter.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia_gpu_exporter
sudo systemctl status nvidia_gpu_exporter
```

Check that the dashboard is green in Grafana.

## prometheus

### snapshots
```
curl -XPOST 127.0.0.1:9090/api/v1/admin/tsdb/snapshot
```


## collectors

## grafana

## victoria metrics

### import a snapshot from prometheus

```
vmctl prometheus --prom-snapshot=/var/lib/prometheus/metrics2/snapshots/20240702T061551Z-7344f83b455ab9a1 --vm-concurrency=1 --vm-batch-size=200000 --prom-concurrency=3
```

### add a daemon to copy data from prometheus to victoria

```
cp ~pierre/scrapers/systemd/victoria-vmagent.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now victoria-vmagent.service 
```

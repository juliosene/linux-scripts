sudo apt install containerd
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo swapoff -a
sed -i 's/\/swap.img/# \/swap.img/g /etc/fstab
sudo modprobe overlay
sudo modprobe br_netfilter
cat<<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# Mosec

Vagrant build for testing mobile apps. Some notes are for myself but maybe useful for anyone.

## Usage

Make sure you have the lastest vagrant, virtualbox and virtual box extension pack. To install the extension pack after downloading it:

```
VBoxManage extpack install --replace /Users/santran/Downloads/Oracle_VM_VirtualBox_Extension_Pack-6.0.14.vbox-extpack
```

Start the VM using the following 

```
cd mosec
vagrant up
```

SSH to the VM using the following and start adb under root to make sure it has sufficient permission otherwise you will run into `????????????    no permissions` issue

```
vagrant ssh
sudo adb start-server
adb devices
```

Tools can be found in the following location

```
/home/vagrant
```

To share data between host and VM write files to the following location in the VM:

```
/home/vagrant/shared
```

## Contributing

Changes are welcome, please create a PR explaining the purpose of the change in detail, avoid submitting commercial tools.

## License

This Vagrant configuration is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

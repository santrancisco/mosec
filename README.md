# Mosec

Vagrant build for testing mobile apps. Some notes are for myself but maybe useful for anyone.

## Usage

Start the VM using the following 

```
cd mosec
vagrant up
```

SSH to the VM using the following

```
vagrant ssh
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

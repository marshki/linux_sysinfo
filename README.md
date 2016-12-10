# Bash System Info  
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

Bash script to extract useful information from a `Linux` host using a menu-driven interface.
This script will be tested to run in: Centos 7, Debian 8 & Ubuntu 16.04, though it should work on other distros as well. 

** UPDATE (2016.11.01): ** 

Forked program in to two distinct branches--one for Linux-based OSs and another for OS X / FreeBSD. 

Still a work in progress (2016.11.26), but can be used as is.  

# TODO

- [ ] Get to work on: 
    - [ ] Centos 7
    - [x] Debian 8
    - [x] Ubuntu 16.04
- [x] `lsb_module`, used in `os_info` is not installed universally. 
      We need a workaround (regex on `cat /etc/os-release`, perhaps?) --> see Issue # 14  
- [x] Overly verbose output for: `ps auxf |sort -nr -k 4 |head -5` 
- [x] go with verbose command line options when possible 
- [x] Add function for disk space and top ten diski-eating files 
- [ ] Defeat more badness as it comes up

# History 

First commit 2016.10.07

# License 

[MIT license](https://opensource.org/licenses/MIT). 'Nuff said. 

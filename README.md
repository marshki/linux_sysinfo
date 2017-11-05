# Bash System Info  
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

Bash script to extract useful information from a `Linux` host using a menu-driven interface.
This script builds on, and improves *grabsysinfo.sh* attributed to Vivek Gite circa 2007.09.12. 

Tested to run on: Centos 7, Debian 8 & Ubuntu 16.04, though it should work on other distros as well. 

** UPDATE (2017.11.05): ** 

Still a work in progress, but can be used as is.  

# Getting Started 

For the whole enchillada run as `root`: 

`bash system_info.sh`. 

This will present you with a text-based menu from which you can make a selection: ![Alt text](https://github.com/marshki/bash_sys_info/blob/master/screen_grab.png "screen_grab.png")
 

# TODO

- [ ] `disk_space` function needs to provide user with feedback. `find` command can take eons depending on disk usage, but verbose find is too noisy, and `pv` won't work utill find command completes.  
- [ ] [Whiptail Menu](https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail) integration (long-term goal)
- [ ] Add "report" function to pull information and e-mail sysadmin? 
- [ ] General code quality review & cleanup. 

# History 

First commit 2016.10.07

# License 

[MIT license](https://opensource.org/licenses/MIT). 'Nuff said. 

# Acknowledgments 



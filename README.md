# DockLock
Hardened Docker Container

## Details
- Uses official Ubuntu 20.04 image as default
- Disables priviliged user
- Uses Seccomp to limit allowed syscalls 
- 

### Seccomp setup
Secure computing mode (seccomp) is a Linux kernel feature. You can use it to restrict the actions available within the container. Find out more about Seccomp security profiles from the official [Seccomp security profiles for Docker](https://docs.docker.com/engine/security/seccomp/).

By Default the standard seccomp profile is used.

It is possible to create a specific profile for the container that only whitelists the required syscalls. [syscall2seccomp](https://github.com/antitree/syscall2seccomp) can be utilised to build a custom Docker seccomp profile in JSON. `syscall2seccomp` cant pull the syscalls itself so either `strace` or `sysdig` are used. `sysdig` is preferred as it typically catches more traces and is more container specific.

Profiles are defined using:
 `docker run --security-option seccomp="custom_seccomp_profile"` 

It should be noted that if an unexpected or rare syscall that you didn't account for happens your container will be terminated.

### Apparmor setup
AppArmor is a Linux kernel security module that allows the system administrator to restrict programs' capabilities with per-program profiles. These profiles when used with docker are used on containers. Docker outlines the use of apparmor [here](https://docs.docker.com/engine/security/apparmor/).

Again it uses the `--security-opt` flag in:
`docker run --security-option apparmor="custom_apparmor_profile"`    
When used with seccomp the flag will need to repeated.

Profile creation and debugging can be a bit of a nightmare. You can use `dmesg` to debug problems and `aa-status` check the loaded profiles. Another lifesaver tool used for Docker specific profile generation here is [bane](https://github.com/genuinetools/bane). 

TODO: Apparmour setup

### Benchmarks and Compliance
TODO: Test - Center for internet security benchmark
TODO: Test - Dockers own [docker-bench-security](https://hub.docker.com/r/docker/docker-bench-security)

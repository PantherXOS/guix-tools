# Guix Tools

A collection of Guix tools.

## Package Index

### to File

A tiny tool, to output the current _guix_ package index, to file.

```bash
$ guix-tools package -json index.json
```

example output, showing individual entry:

```json
[
    {
        "name": "git",
        "version": "2.20.1",
        "outputs": "out send-email svn credential-netrc subtree gui",
        "systems": "x86_64-linux i686-linux armhf-linux aarch64-linux",
        "dependencies": "asciidoc@8.6.10 bash@4.4.23 curl@7.61.1 docbook-xsl@1.79.1 expat@2.2.6 gettext-minimal@0.19.8.1 openssl@1.0.2p perl-authen-sasl@2.16 perl-cgi@4.38 perl-io-socket-ssl@2.038 perl-net-smtp-ssl@1.04 perl-term-readkey@2.37 perl@5.28.0 python2@2.7.15 subversion@1.10.2 tcl@8.6.8 tk@8.6.8 xmlto@0.0.28 zlib@1.2.11",
        "location": "location: gnu/packages/version-control.scm:145:2",
        "homepage": "https://git-scm.com/",
        "license": "GPL 2",
        "synopsis": "Distributed version control system",
        "description": "Git is a free distributed version control system designed to handle everything from small to very large projects with speed and efficiency."
    },
    ...
]
```
# Linuxbrew Xorg


[Xorg libraries](http://www.x.org/wiki/guide/client-ecosystem/) for Linuxbrew users

## Install

```bash
brew tap linuxbrew/homebrew-xorg &&
brew install xorg
```

This will install (all) Xorg libraries. To see the progress of the installation, enable verbose messaging by providing the `-v` (`--verbose`) flag:

```bash
brew install -v xorg
```

You can also install individual libraries/packages  provided in this tap by running

```bash
brew install <formula-name>
```

## Requirements

Main dependencies of the Xorg libraries are:
  * `pkg-config`: to build packages from source
  * `fontconfig`: required by `libxft`
  * `freetype`:   required by `libxfont`
  * `python`:     required by `xcb-proto`

To build documentation (enabled with `--with-docs` flag), the following packages are required:
  * `xorg-sgml-doctools`
  * `xmlto`
  * `fop`<sup>1</sup>
  * `libxslt`
  * `asciidoc`
  * `w3m`<sup>2</sup>

*1*: reciprocal dependency is not resolved at the present time but it does not affect the build process
<br>
*2*: Not used at the moment

## Details

Installation proceeds according to the instructions from [Linux From Scratch](http://www.linuxfromscratch.org/blfs/view/stable/x/x7lib.html)

To build documentation, use `--with-docs` flag, _i.e._:

```bash
brew install xorg --with-docs
```

This will install `xorg-docs` package and enable the following dependencies: `fop`, `libxslt`, `xmlto`. 
There is an additional dependency on `asciidoc` for `inputproto` and `libxi` packages.

To see the list of optional flags when compiling libraries with documentation, use:

```bash
brew info xorg --with-docs
```

When building packages from source code, compile-time tests are enabled by default.
To skip then, use `--without-test` flag, _i.e._:

```bash
brew install xorg --build-from-source --without-test
```

You can also build static libraries (though, this is neither required nor recommended) using `--with-static` flag, _i.e._:

```bash
brew install xorg --with-static
```

You can combine (all) of the above options (flags), _i.e._:

```bash
brew install xorg --with-docs
```

## Issues / Ongoing work

* Reciprocal dependency with `fop` is not resolved. As a result, not all documentation might be built.
* Provide other Xorg packages

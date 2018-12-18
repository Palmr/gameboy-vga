# FPGA Game Boy Framebuffer

My attempts at hooking in to the Game Boy LCD cable to sniff frame data.

Currently only looking at the Game Boy Pocket as I have one with screen rot and would ideally like to add other output options or replace the screen with something else.

## Requirements

Currently running off an [Lattice Semi](http://www.latticesemi.com) [iCEblink40LP1K devkit](http://www.latticesemi.com/iCEblink40-LP1K).

After cloning this repository make sure to pull in the submodule for building/flashing the RTL

```bash
git submodule update --init
```

This should pull in my forked version of the excellent [fpga-tools](https://github.com/pwmarcz/fpga-tools/) submodule by [Paweł Marczewski](https://github.com/pwmarcz).

Required software:

- [Project IceStorm](http:///www.clifford.at/icestorm/)
- [iceBurn](https://github.com/davidcarne/iceBurn)
- GTKWave (for `make sim` target)

## RTL

Currently just experimenting, [see the rtl/exploration/Readme.md](./rtl/exploration/Readme.md) for more on that.

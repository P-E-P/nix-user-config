self: super:
{
  qemu = super.qemu.override {
    hostCpuTargets = ["sparc-softmmu" "sparc64-softmmu"];
  };
}

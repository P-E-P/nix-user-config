self: super:
{
  boost = super.boost.override {
    enableShared = true;
    enabledStatic = true;
  };
}



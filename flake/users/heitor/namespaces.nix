{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "heitor" true)
    (inputs.den.namespace "_heitor" false)
  ];
}

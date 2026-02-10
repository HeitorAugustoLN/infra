{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "system" true)
    (inputs.den.namespace "_system" false)
  ];
}

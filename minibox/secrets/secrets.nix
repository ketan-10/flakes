let 
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDBj+uYoBhd3ckiHCKDuFLhNEJA/Ux4cUSAEjsTfdjW"; 
in 
{
  "secret1.age".publicKeys = [
    user1
  ];
}
